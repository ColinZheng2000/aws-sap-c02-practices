# scan-new-questions.ps1
# Purpose: Scan all wrong-answer .md files, extract YAML frontmatter, and generate a chapter-grouped report
# Usage: .\scripts\scan-new-questions.ps1 [-NewerThan QID]
# Example: .\scripts\scan-new-questions.ps1 -NewerThan 300
#          (scans files with qid > 300 for new additions)

param(
    [int]$NewerThan = 0  # Only scan files with qid > this number
)

$root = Split-Path -Parent $PSScriptRoot
$reportDir = "$PSScriptRoot"
$reportFile = "$reportDir\report-new-questions.md"

# Chapter mapping
$chapterNames = @{
    "00" = "Cross-Cutting Concepts"
    "01" = "Compute"
    "02" = "Containers"
    "03" = "Storage"
    "04" = "Database"
    "05" = "Networking & Content Delivery"
    "06" = "Security, Identity & Compliance"
    "07" = "Application Integration"
    "08" = "Management & Governance"
    "09" = "Migration & Transfer"
    "10" = "Analytics"
    "11" = "Machine Learning"
    "12" = "Developer Tools"
    "13" = "End User Computing & Hybrid"
}

Write-Host "=== AWS SAP-C02 New Question Scanner ===" -ForegroundColor Cyan
Write-Host "Scanning: $root" -ForegroundColor Gray
Write-Host ""

$results = @{}
$totalFiles = 0
$filesWithYaml = 0
$filesWithoutYaml = 0

# Get all .md files in root (exclude known non-question files)
$excludePatterns = @(
    "README.md", "AWS-SAP-C02-Learning-Material.md", "AWS-SAP-C02-Learning-Material-CN.md",
    "999. AI Prompt.md", "CHANGELOG.md", "Interview-Quick-Reference.md",
    "Exam-Tactics.md"
)

Get-ChildItem -Path $root -Filter "*.md" | Where-Object {
    $_.Name -notin $excludePatterns -and $_.Name -notlike "AWS-SAP-C02*"
} | ForEach-Object {
    $file = $_
    $content = Get-Content $file.FullName -Raw
    $totalFiles++

    # Extract YAML frontmatter (between --- markers)
    if ($content -match '---\s*\n(.*?)\n---') {
        $yamlBlock = $matches[1]
        
        # Parse YAML fields
        $qid = if ($yamlBlock -match 'qid:\s*(\d+)') { [int]$matches[1] } else { 
            # Try extracting from filename
            if ($file.BaseName -match '^(\d+)') { [int]$matches[1] } else { 0 }
        }
        $chapter = if ($yamlBlock -match 'chapter:\s*(\d+)') { $matches[1] } else { "??" }
        $services = if ($yamlBlock -match 'services:\s*\[(.*?)\]') { $matches[1] } else { "" }
        $difficulty = if ($yamlBlock -match 'difficulty:\s*(.+)') { $matches[1].Trim() } else { "??" }
        $interview = if ($yamlBlock -match 'interview_relevance:\s*(.+)') { $matches[1].Trim() } else { "??" }
        $domains = if ($yamlBlock -match 'exam_domains:\s*\[(.*?)\]') { $matches[1] } else { "" }

        # Skip if filtering by NewerThan
        if ($NewerThan -gt 0 -and $qid -le $NewerThan) { return }

        $filesWithYaml++

        if (-not $results.ContainsKey($chapter)) {
            $results[$chapter] = @()
        }
        $results[$chapter] += [PSCustomObject]@{
            QID = $qid
            File = $file.Name
            Services = $services
            Difficulty = $difficulty
            Interview = $interview
            Domains = $domains
        }
    } else {
        # No YAML frontmatter found - count as legacy format
        if ($NewerThan -gt 0) { return }  # Skip legacy files in NewerThan mode
        $filesWithoutYaml++
        $legacyQid = if ($file.BaseName -match '^(\d+)') { [int]$matches[1] } else { 0 }
        if ($legacyQid -eq 0) { return }
        
        if (-not $results.ContainsKey("legacy")) {
            $results["legacy"] = @()
        }
        $results["legacy"] += [PSCustomObject]@{
            QID = $legacyQid
            File = $file.Name
            Services = "⚠️ NO YAML"
            Difficulty = "??"
            Interview = "??"
            Domains = ""
        }
    }
}

# Generate report
$report = @"
# New Questions Scan Report
**Generated**: $(Get-Date -Format 'yyyy-MM-dd HH:mm')
**Total files scanned**: $totalFiles
**Files with YAML frontmatter**: $filesWithYaml
**Files without YAML (legacy)**: $filesWithoutYaml
**Filter**: $(if ($NewerThan -gt 0) { "QID > $NewerThan" } else { "All files" })

---

"@

# Report by chapter
foreach ($ch in ($results.Keys | Sort-Object)) {
    $items = $results[$ch]
    if ($ch -eq "legacy") {
        $report += "## ⚠️ Legacy Format (No YAML Frontmatter)`n`n"
        $report += "These files need to be updated to the standardized format.`n`n"
        $report += "| QID | File |`n"
        $report += "|-----|------|`n"
        foreach ($item in $items | Sort-Object QID) {
            $report += "| $($item.QID) | $($item.File) |`n"
        }
    } else {
        $chName = if ($chapterNames.ContainsKey($ch)) { $chapterNames[$ch] } else { "Unknown Chapter $ch" }
        $report += "## Ch $ch — $chName ($($items.Count) files)`n`n"
        $report += "| QID | File | Services | Difficulty | Interview | Domains |`n"
        $report += "|-----|------|----------|------------|-----------|---------|`n"
        foreach ($item in $items | Sort-Object QID) {
            $report += "| $($item.QID) | $($item.File) | $($item.Services) | $($item.Difficulty) | $($item.Interview) | $($item.Domains) |`n"
        }
    }
    $report += "`n"
}

$report += "---`n"
$report += "## Action Items`n`n"

# Generate action items for each chapter with files
foreach ($ch in ($results.Keys | Sort-Object)) {
    if ($ch -eq "legacy") { continue }
    $items = $results[$ch]
    $chName = if ($chapterNames.ContainsKey($ch)) { $chapterNames[$ch] } else { "Unknown Chapter $ch" }
    $uniqueServices = ($items.Services -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ } | Sort-Object -Unique) -join ', '
    $report += "- **Ch $ch $chName** ($($items.Count) new files)`n"
    $report += "  - New QIDs: $(($items.QID | Sort-Object) -join ', ')`n"
    $report += "  - Services to update: $uniqueServices`n"
    $report += "  - `<!-- UPDATE_MARKER` targets identified`n`n"
}

$report | Set-Content $reportFile -Encoding UTF8

Write-Host "Report saved to: $reportFile" -ForegroundColor Green
Write-Host ""
Write-Host "Summary:" -ForegroundColor Yellow
foreach ($ch in ($results.Keys | Sort-Object)) {
    $count = $results[$ch].Count
    if ($ch -eq "legacy") {
        Write-Host "  Legacy (no YAML): $count files" -ForegroundColor Red
    } else {
        $chName = if ($chapterNames.ContainsKey($ch)) { $chapterNames[$ch] } else { "Ch $ch" }
        Write-Host "  Ch $ch $chName : $count files" -ForegroundColor White
    }
}
