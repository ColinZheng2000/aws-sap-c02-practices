# check-qref-consistency.ps1
# Purpose: Compare wrong-answer file QIDs against textbook Q Ref citations to find missing references
# Usage: .\scripts\check-qref-consistency.ps1

$root = Split-Path -Parent $PSScriptRoot
$textbook = "$root\AWS-SAP-C02-Learning-Material.md"
$reportDir = "$PSScriptRoot"
$reportFile = "$reportDir\report-qref-mismatch.md"

Write-Host "=== AWS SAP-C02 Q Ref Consistency Checker ===" -ForegroundColor Cyan

# Step 1: Extract all QIDs from wrong-answer files
Write-Host "Scanning wrong-answer files..." -ForegroundColor Gray
$allQids = @{}
Get-ChildItem -Path $root -Filter "*.md" | Where-Object {
    $_.Name -match '^\d+\.md$' -or $_.Name -match '^\d+,\d+\.md$'
} | ForEach-Object {
    $file = $_
    if ($file.BaseName -match '^(\d+)') {
        $qid = [int]$matches[1]
        $allQids[$qid] = $file.Name
    }
    # Handle comma-separated files like "67,68.md"
    if ($file.BaseName -match ',(\d+)') {
        $qid2 = [int]$matches[1]
        $allQids[$qid2] = $file.Name
    }
}
Write-Host "  Found $($allQids.Count) unique QIDs in wrong-answer files" -ForegroundColor Green

# Step 2: Extract all Q Refs from textbook
Write-Host "Scanning textbook Q Refs..." -ForegroundColor Gray
$textbookContent = Get-Content $textbook -Raw
$refPattern = '#(\d+)'
$refMatches = [regex]::Matches($textbookContent, $refPattern)
$citedQids = @{}
foreach ($match in $refMatches) {
    $qid = [int]$match.Groups[1].Value
    if (-not $citedQids.ContainsKey($qid)) {
        $citedQids[$qid] = $true
    }
}
Write-Host "  Found $($citedQids.Count) unique QIDs cited in textbook" -ForegroundColor Green

# Step 3: Compare
$notCited = @()
foreach ($qid in $allQids.Keys | Sort-Object) {
    if (-not $citedQids.ContainsKey($qid)) {
        $notCited += $qid
    }
}

$notFound = @()
foreach ($qid in $citedQids.Keys | Sort-Object) {
    if (-not $allQids.ContainsKey($qid)) {
        $notFound += $qid
    }
}

# Step 4: Generate report
$report = @"
# Q Ref Consistency Report
**Generated**: $(Get-Date -Format 'yyyy-MM-dd HH:mm')
**Total wrong-answer files**: $($allQids.Count)
**Total Q Ref citations in textbook**: $($citedQids.Count)

---

"@

if ($notCited.Count -eq 0 -and $notFound.Count -eq 0) {
    $report += "## ✅ All Q Refs are consistent!`n`n"
    $report += "Every wrong-answer file is cited in the textbook, and every textbook citation has a corresponding file.`n"
    Write-Host "OK - All Q Refs consistent!" -ForegroundColor Green
} else {
    if ($notCited.Count -gt 0) {
        $report += "## ❌ Wrong-Answer Files NOT Cited in Textbook ($($notCited.Count) files)`n`n"
        $report += "These files exist but are not referenced in any `📝 Q Refs`:`n`n"
        $report += "| QID | File |`n"
        $report += "|-----|------|`n"
        foreach ($qid in $notCited) {
            $report += "| $qid | $($allQids[$qid]) |`n"
        }
        $report += "`n**Action**: Add these QIDs to the appropriate service subsection's `📝 Q Refs` in the textbook.`n`n"
        Write-Host "MISMATCH: $($notCited.Count) files NOT cited in textbook" -ForegroundColor Red
    }
    
    if ($notFound.Count -gt 0) {
        $report += "## ⚠️ Textbook Citations Without Files ($($notFound.Count) citations)`n`n"
        $report += "These QIDs appear in the textbook but no corresponding file exists:`n`n"
        $report += "QIDs: $($notFound -join ', ')`n`n"
        $report += "**Action**: Either create the missing file or remove the stale citation.`n`n"
        Write-Host "WARNING: $($notFound.Count) citations without files" -ForegroundColor Yellow
    }
}

$report += "---`n"
$report += "## Statistics by Chapter`n`n"
$report += "| Chapter | Files | Cited | Coverage |`n"
$report += "|---------|-------|-------|----------|`n"

# Chapter assignments (simplified - full mapping would require YAML parsing)
# This provides a rough overview based on the textbook structure
$chapters = @{
    "00" = @("Cross-Cutting"); "01" = @("Compute"); "02" = @("Containers")
    "03" = @("Storage"); "04" = @("Database"); "05" = @("Networking")
    "06" = @("Security"); "07" = @("Integration"); "08" = @("Management")
    "09" = @("Migration"); "10" = @("Analytics"); "11" = @("ML")
    "12" = @("DevTools"); "13" = @("EUC")
}

$report += "| - | $($allQids.Count) | $($citedQids.Count) | $([math]::Round($citedQids.Count / [Math]::Max($allQids.Count,1) * 100, 1))% |`n"

$report | Set-Content $reportFile -Encoding UTF8
Write-Host "Report saved to: $reportFile" -ForegroundColor Green
