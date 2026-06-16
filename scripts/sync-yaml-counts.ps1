# sync-yaml-counts.ps1
# Purpose: Automatically count actual questions in practice files and update YAML frontmatter
# Usage: .\scripts\sync-yaml-counts.ps1 [-DryRun]
#   -DryRun: Show what WOULD change without modifying files

param([switch]$DryRun)

$root = Split-Path -Parent $PSScriptRoot
$practiceDir = "$root\practice"
$reportDir = "$PSScriptRoot"
$reportFile = "$reportDir\report-yaml-sync.md"

Write-Host "=== AWS SAP-C02 Practice File YAML Sync ===" -ForegroundColor Cyan
if ($DryRun) { Write-Host "DRY RUN - No files will be modified" -ForegroundColor Yellow }

$report = @"
# Practice File YAML Sync Report
**Generated**: $(Get-Date -Format 'yyyy-MM-dd HH:mm')
**Mode**: $(if ($DryRun) { 'Dry Run' } else { 'Live' })

---

"@

$totalActual = 0
$totalYaml = 0
$synced = 0
$mismatches = 0

Get-ChildItem -Path $practiceDir -Filter "Practice-Ch-*.md" | Sort-Object Name | ForEach-Object {
    $file = $_
    $content = Get-Content $file.FullName -Raw
    
    # Count actual questions
    $actualQuestions = ([regex]::Matches($content, '### Q\d+\.\d+')).Count
    
    # Count by tier
    $knowledgeQuestions = ([regex]::Matches($content, '### Q\d+\.\d+')).Count  # Will refine below
    
    # Extract YAML values
    $yamlTotal = if ($content -match 'totalQuestions:\s*(\d+)') { [int]$matches[1] } else { 0 }
    $yamlKnowledge = if ($content -match 'knowledge:\s*(\d+)') { [int]$matches[1] } else { 0 }
    $yamlScenario = if ($content -match 'scenario:\s*(\d+)') { [int]$matches[1] } else { 0 }
    $yamlComparison = if ($content -match 'comparison:\s*(\d+)') { [int]$matches[1] } else { 0 }
    
    $totalActual += $actualQuestions
    $totalYaml += $yamlTotal
    
    $status = if ($yamlTotal -eq $actualQuestions) { "OK" } else { "MISMATCH" }
    
    if ($yamlTotal -ne $actualQuestions) {
        $mismatches++
        $report += "## $($file.Name) — MISMATCH`n`n"
        $report += "- YAML says: $yamlTotal questions (K:$yamlKnowledge S:$yamlScenario C:$yamlComparison)`n"
        $report += "- Actual count: $actualQuestions questions`n"
        
        if (-not $DryRun) {
            # Update the YAML
            $newContent = $content -replace 'totalQuestions:\s*\d+', "totalQuestions: $actualQuestions"
            
            # Note: Tier counts require deeper analysis of question types
            # For now, we keep the existing tier YAML and just fix totalQuestions
            # Manual tier adjustment is recommended
            
            $newContent | Set-Content $file.FullName -NoNewline
            Write-Host "  Fixed: $($file.Name) — YAML $yamlTotal → $actualQuestions" -ForegroundColor Green
            $synced++
        } else {
            Write-Host "  Would fix: $($file.Name) — YAML $yamlTotal → $actualQuestions" -ForegroundColor Yellow
        }
        $report += "- **Action**: YAML updated to $actualQuestions (tier counts may need manual adjustment)`n`n"
    } else {
        $report += "## $($file.Name) — OK`n`n"
        $report += "- $actualQuestions questions (K:$yamlKnowledge S:$yamlScenario C:$yamlComparison)`n`n"
    }
}

$report += "---`n"
$report += "## Summary`n`n"
$report += "| Metric | Value |`n"
$report += "|--------|-------|`n"
$report += "| Total YAML questions | $totalYaml |`n"
$report += "| Total actual questions | $totalActual |`n"
$report += "| Files with mismatches | $mismatches |`n"
$report += "| Files synced | $synced |`n"

$report | Set-Content $reportFile -Encoding UTF8

Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Cyan
Write-Host "Total YAML: $totalYaml | Total Actual: $totalActual | Mismatches: $mismatches" -ForegroundColor White
if ($synced -gt 0) { Write-Host "Synced: $synced files" -ForegroundColor Green }
Write-Host "Report: $reportFile" -ForegroundColor Gray
