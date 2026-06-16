# add-wikilinks.ps1
# Phase B+C: Fix difficulty tags + add [[wikilinks]] to wrong-answer files
# Usage: .\scripts\add-wikilinks.ps1 [-DryRun]

param([switch]$DryRun)

$root = Split-Path -Parent $PSScriptRoot
Write-Host "=== Wiki Link + Tag Fix Tool ===" -ForegroundColor Cyan
if ($DryRun) { Write-Host "DRY RUN - preview only" -ForegroundColor Yellow }

# Chapter -> Textbook heading anchor and Practice file
$chToLinks = @{
    'Ch 00' = @{Textbook='AWS-SAP-C02-Learning-Material#cross-cutting-concerns'; Practice='Practice-Ch-00-CrossCutting'}
    'Ch 01' = @{Textbook='AWS-SAP-C02-Learning-Material#compute'; Practice='Practice-Ch-01-Compute'}
    'Ch 02' = @{Textbook='AWS-SAP-C02-Learning-Material#containers'; Practice='Practice-Ch-02-Containers'}
    'Ch 03' = @{Textbook='AWS-SAP-C02-Learning-Material#storage'; Practice='Practice-Ch-03-Storage'}
    'Ch 04' = @{Textbook='AWS-SAP-C02-Learning-Material#database'; Practice='Practice-Ch-04-Database'}
    'Ch 05' = @{Textbook='AWS-SAP-C02-Learning-Material#networking'; Practice='Practice-Ch-05-Networking'}
    'Ch 06' = @{Textbook='AWS-SAP-C02-Learning-Material#security'; Practice='Practice-Ch-06-Security'}
    'Ch 07' = @{Textbook='AWS-SAP-C02-Learning-Material#integration'; Practice='Practice-Ch-07-Integration'}
    'Ch 08' = @{Textbook='AWS-SAP-C02-Learning-Material#management'; Practice='Practice-Ch-08-Management'}
    'Ch 09' = @{Textbook='AWS-SAP-C02-Learning-Material#migration'; Practice='Practice-Ch-09-Migration'}
    'Ch 10' = @{Textbook='AWS-SAP-C02-Learning-Material#analytics'; Practice='Practice-Ch-10-Analytics'}
    'Ch 11' = @{Textbook='AWS-SAP-C02-Learning-Material#machine-learning'; Practice='Practice-Ch-11-MachineLearning'}
    'Ch 12' = @{Textbook='AWS-SAP-C02-Learning-Material#devtools'; Practice='Practice-Ch-12-DevTools'}
    'Ch 13' = @{Textbook='AWS-SAP-C02-Learning-Material#euc'; Practice='Practice-Ch-13-EUC'}
}

$files = Get-ChildItem "$root\[0-9]*.md" | Where-Object { $_.Name -match '^\d+\.md$' } | Sort-Object { [int]$_.BaseName }
$processed = 0

foreach ($file in $files) {
    $raw = Get-Content $file.FullName -Raw -Encoding UTF8
    if ($raw -notmatch '^---') { continue }
    
    # Extract chapter
    $ch = 'Ch 00'
    if ($raw -match 'chapter:\s*"(Ch \d+)"') { $ch = $Matches[1] }
    
    # Extract difficulty
    $diff = '🟡'
    if ($raw -match 'difficulty:\s*(.+)') { $diff = $Matches[1].Trim() }
    
    $diffTag = 'difficulty/l2-understanding'
    if ($diff -match '🟢') { $diffTag = 'difficulty/l1-knowledge' }
    elseif ($diff -match '🔴') { $diffTag = 'difficulty/l3-application' }
    
    # Get links
    $links = $chToLinks[$ch]
    if (-not $links) { $links = $chToLinks['Ch 00'] }
    $tb = $links.Textbook
    $pr = $links.Practice
    
    # Build Related Files section
    $relatedSection = @"

---

## Related Files
- 📖 [[$tb|Textbook: $ch]]
- 📋 [[$pr|Practice Questions: $ch]]
- 🔀 [[Architecture-Decision-Trees|Architecture Decision Trees]]
- 🗺️ [[Task-Statement-Mapping|Exam Task Statement Map]]
"@
    
    # Skip if already has Related Files section
    if ($raw -match '## Related Files') {
        $processed++
        continue
    }
    
    # Add diff tag to tags list (after resource/wrong-answer)
    $newRaw = $raw
    
    # Insert difficulty tag after resource/wrong-answer line
    $newRaw = $newRaw -replace '(  - resource/wrong-answer)\r?\n', "`$1`n  - $diffTag`n"
    
    # Append Related Files section at end
    $newRaw = $newRaw.TrimEnd() + "`n" + $relatedSection + "`n"
    
    if ($DryRun) {
        Write-Host "DRY: $($file.Name) [$ch, $diffTag]"
    } else {
        [System.IO.File]::WriteAllText($file.FullName, $newRaw, [System.Text.UTF8Encoding]::new($false))
        Write-Host "OK: $($file.Name)" -ForegroundColor Green
    }
    $processed++
}

Write-Host "`n=== Summary ===" -ForegroundColor Cyan
Write-Host "Processed: $processed files"
if ($DryRun) { Write-Host "Rerun without -DryRun to apply" -ForegroundColor Yellow }
