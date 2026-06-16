# label-practice-questions.ps1
# Purpose: Batch-label all practice questions with difficulty + interview relevance tags
# Usage: .\scripts\label-practice-questions.ps1 [-DryRun] [-TargetFile "Practice-Ch-01-Compute.md"]
#   -DryRun: Preview labels without modifying files
#   -TargetFile: Process only one specific file

param(
    [switch]$DryRun,
    [string]$TargetFile = ""
)

$root = Split-Path -Parent $PSScriptRoot
$practiceDir = "$root\practice"

Write-Host "=== Practice Question Labeling Tool ===" -ForegroundColor Cyan
if ($DryRun) { Write-Host "DRY RUN — no files modified" -ForegroundColor Yellow }

# Default labeling rules based on question content patterns
# Format: @{Pattern = @('difficulty', 'interview')}
# Priority: First matching pattern wins (check patterns in order)
$labelingRules = @(
    # L1 Knowledge patterns
    @{Pattern = 'maximum (timeout|execution|retention)'; Diff = '🟢 L1-知识'; Interview = '🎤🎤 中频面试'},
    @{Pattern = 'What is the (purpose|primary|maximum|minimum)'; Diff = '🟢 L1-知识'; Interview = '🎤🎤 中频面试'},
    @{Pattern = 'Which of the following (correctly |)describes'; Diff = '🟢 L1-知识'; Interview = '🎤 低频'},
    @{Pattern = 'What (is|are) the.*(difference|metric|purpose)'; Diff = '🟢 L1-知识'; Interview = '🎤🎤 中频面试'},
    
    # L3 Comparison/Application patterns
    @{Pattern = 'Compare |compares '; Diff = '🔴 L3-应用'; Interview = '🎤🎤🎤 高频面试'},
    @{Pattern = 'Which.*(MOST cost-effective|LEAST operational|BEST fit|WORST choice)'; Diff = '🔴 L3-应用'; Interview = '🎤🎤🎤 高频面试'},
    @{Pattern = 'Which.*similar.*service|similar service'; Diff = '🔴 L3-应用'; Interview = '🎤🎤🎤 高频面试'},
    @{Pattern = 'Choose two|Choose three'; Diff = '🔴 L3-应用'; Interview = '🎤🎤🎤 高频面试'},
    @{Pattern = 'RPO.*RTO|disaster recovery.*strategy|DR.*strategy'; Diff = '🔴 L3-应用'; Interview = '🎤🎤🎤 高频面试'},
    @{Pattern = 'Solution.*meet these requirements|design.*solution|architect.*needs'; Diff = '🟡 L2-理解'; Interview = '🎤🎤 中频面试'},
    
    # Default fallback
    @{Pattern = '.'; Diff = '🟡 L2-理解'; Interview = '🎤🎤 中频面试'}
)

function Get-LabelForQuestion {
    param([string]$questionText)
    
    foreach ($rule in $labelingRules) {
        if ($questionText -match $rule.Pattern) {
            return @{
                Difficulty = $rule.Diff
                Interview = $rule.Interview
            }
        }
    }
    return @{Difficulty = '🟡 L2-理解'; Interview = '🎤🎤 中频面试'}
}

# Process files
$files = if ($TargetFile) {
    Get-ChildItem "$practiceDir\$TargetFile" -ErrorAction SilentlyContinue
} else {
    Get-ChildItem "$practiceDir\Practice-Ch-*.md" | Sort-Object Name
}

$totalQuestions = 0
$labeledCount = 0
$dryRunCount = 0

foreach ($file in $files) {
    Write-Host "`nProcessing: $($file.Name)" -ForegroundColor White
    $content = Get-Content $file.FullName -Raw
    
    # Find all questions
    $questionPattern = '### (Q\d+\.\d+)\r?\n'
    $matches = [regex]::Matches($content, $questionPattern)
    
    if ($matches.Count -eq 0) {
        Write-Host "  No questions found" -ForegroundColor Gray
        continue
    }
    
    $newContent = $content
    $fileLabeled = 0
    $fileSkipped = 0
    
    # Process in reverse order to avoid position shifts
    for ($i = $matches.Count - 1; $i -ge 0; $i--) {
        $match = $matches[$i]
        $qId = $match.Groups[1].Value
        
        # Check if already labeled
        $lineAfter = $newContent.Substring($match.Index + $match.Length, [Math]::Min(50, $newContent.Length - $match.Index - $match.Length))
        if ($lineAfter -match '^> [🟢🟡🔴]') {
            $fileSkipped++
            continue
        }
        
        # Get question text (next 200 chars after header)
        $qStart = $match.Index + $match.Length
        $qText = $newContent.Substring($qStart, [Math]::Min(200, $newContent.Length - $qStart))
        
        # Determine label
        $label = Get-LabelForQuestion -questionText $qText
        $labelLine = "`n> $($label.Difficulty) | $($label.Interview)`n"
        
        if ($DryRun) {
            Write-Host "  $qId → $($label.Difficulty) | $($label.Interview)" -ForegroundColor Gray
            $dryRunCount++
        } else {
            # Insert label after the question header line
            $newContent = $newContent.Insert($match.Index + $match.Length, $labelLine)
            $fileLabeled++
            $labeledCount++
        }
        $totalQuestions++
    }
    
    if (-not $DryRun -and $fileLabeled -gt 0) {
        $newContent | Set-Content $file.FullName -NoNewline
        Write-Host "  Labeled: $fileLabeled | Skipped (already labeled): $fileSkipped" -ForegroundColor Green
    }
}

Write-Host "`n=== Summary ===" -ForegroundColor Cyan
if ($DryRun) {
    Write-Host "Dry run — would label $dryRunCount questions across $($files.Count) files" -ForegroundColor Yellow
} else {
    Write-Host "Labeled: $labeledCount questions | Total processed: $totalQuestions" -ForegroundColor Green
}
Write-Host "Run with -DryRun first to preview labels before applying." -ForegroundColor Gray
