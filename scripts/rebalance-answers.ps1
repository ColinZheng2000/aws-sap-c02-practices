# rebalance-answers.ps1
# Purpose: Redistribute answer letters across mock exams so no single letter dominates
# Strategy: Rotate option positions within questions to achieve ~25% per option
# Usage: .\scripts\rebalance-answers.ps1 [-TargetFile "Mock-Exam-A.md"] [-DryRun]

param(
    [string]$TargetFile = "",
    [switch]$DryRun
)

$root = Split-Path -Parent $PSScriptRoot
$practiceDir = "$root\practice"

Write-Host "=== Answer Rebalancing Tool ===" -ForegroundColor Cyan
if ($DryRun) { Write-Host "DRY RUN — no files modified" -ForegroundColor Yellow }

function Rotate-Options {
    param([string]$QuestionBlock, [string]$CurrentAnswer, [int]$Shift)
    
    $options = @('A','B','C','D','E')
    $rotated = @{}
    $newAnswer = ''
    
    # Calculate new position for each option
    for ($i = 0; $i -lt $options.Count; $i++) {
        $newIdx = ($i + $Shift) % $options.Count
        $rotated[$options[$i]] = $options[$newIdx]
        if ($options[$i] -eq $CurrentAnswer) {
            $newAnswer = $options[$newIdx]
        }
    }
    
    # Rotate option labels in question text
    $newBlock = $QuestionBlock
    foreach ($old in $rotated.Keys | Sort-Object -Descending) {
        $new = $rotated[$old]
        $newBlock = $newBlock -replace "(\s)-\s*$old\b", "`$1- [[TEMP_$new]]"
    }
    foreach ($new in $rotated.Values) {
        $newBlock = $newBlock -replace "\[\[TEMP_$new\]\]", $new
    }
    
    return @{
        NewBlock = $newBlock
        NewAnswer = $newAnswer
    }
}

# Process each exam file
$files = if ($TargetFile) {
    Get-ChildItem "$practiceDir\$TargetFile" -ErrorAction SilentlyContinue
} else {
    Get-ChildItem "$practiceDir\Mock-Exam-*.md" | Sort-Object Name
}

foreach ($file in $files) {
    Write-Host "`nProcessing: $($file.Name)" -ForegroundColor White
    $content = Get-Content $file.FullName -Raw
    
    # Extract answer key
    $answerMap = @{}
    $keyLines = $content -split "`n" | Where-Object { $_ -match '^\|\s*(\d+)\s*\|\s*([A-E])\s*\|' }
    foreach ($line in $keyLines) {
        if ($line -match '^\|\s*(\d+)\s*\|\s*([A-E])\s*\|') {
            $qNum = [int]$matches[1]
            $answer = $matches[2]
            $answerMap[$qNum] = $answer
        }
    }
    
    if ($answerMap.Count -eq 0) {
        Write-Host "  No answer key found — skipping" -ForegroundColor Yellow
        continue
    }
    
    # Current distribution
    $currentDist = $answerMap.Values | Group-Object | ForEach-Object { "$($_.Name):$($_.Count)" }
    Write-Host "  Current: $($currentDist -join ' | ')" -ForegroundColor Gray
    
    # Build rotation plan: greedy algorithm to balance distribution
    $options = @('A','B','C','D')
    $counts = @{A=0; B=0; C=0; D=0}
    $rotationPlan = @{}
    $newAnswers = @{}
    
    foreach ($qNum in ($answerMap.Keys | Sort-Object)) {
        $currentAnswer = $answerMap[$qNum]
        # For "Choose two" questions (answers like "A, B"), handle differently
        if ($currentAnswer -match ',') {
            $newAnswers[$qNum] = $currentAnswer
            continue
        }
        
        # Find the least-used target option
        $target = $options | Sort-Object { $counts[$_] } | Select-Object -First 1
        
        $currentIdx = [array]::IndexOf($options, $currentAnswer)
        $targetIdx = [array]::IndexOf($options, $target)
        if ($currentIdx -lt 0 -or $targetIdx -lt 0) { 
            $newAnswers[$qNum] = $currentAnswer
            continue 
        }
        
        $shift = ($targetIdx - $currentIdx + 4) % 4
        $newAnswer = $options[($currentIdx + $shift) % 4]
        
        $newAnswers[$qNum] = $newAnswer
        $counts[$newAnswer]++
        
        $rotationPlan[$qNum] = @{
            Old = $currentAnswer
            New = $newAnswer
            Shift = $shift
        }
    }
    
    # New distribution
    $newDist = $newAnswers.Values | Group-Object | ForEach-Object { "$($_.Name):$($_.Count)" }
    Write-Host "  Target:  $($newDist -join ' | ')" -ForegroundColor Green
    
    if ($DryRun) { continue }
    
    # Actually rotate the options in each question
    # Find each question block (from ### QN to the next ### or ---)
    $questionPattern = '(?s)(### Q\d+\r?\n.*?)(?=\r?\n### Q\d+|\r?\n---|\r?\n# Part B)'
    $matches = [regex]::Matches($content, $questionPattern)
    
    $newContent = $content
    
    for ($i = $matches.Count - 1; $i -ge 0; $i--) {
        $match = $matches[$i]
        $qBlock = $match.Value
        
        # Extract Q number
        if ($qBlock -match '### Q(\d+)') {
            $qNum = [int]$matches[1]
        } else { continue }
        
        if (-not $rotationPlan.ContainsKey($qNum)) { continue }
        
        $plan = $rotationPlan[$qNum]
        $shift = $plan.Shift
        
        # Rotate option letters in the question block
        $newBlock = $qBlock
        $options = @('A','B','C','D')
        
        foreach ($old in $options) {
            $oldIdx = [array]::IndexOf($options, $old)
            $newIdx = ($oldIdx + $shift) % 4
            $new = $options[$newIdx]
            # Replace option markers: "- A." → "- [[TMP_X]]."
            $newBlock = $newBlock -replace "(- )$old\.", "`$1[[TMP_$new]]."
            # Replace in "Choose two" format too: "A. " and "B. "
            $newBlock = $newBlock -replace "\b$old\.\s*`{", "[[TMP_$new]]. {"
        }
        foreach ($new in $options) {
            $newBlock = $newBlock -replace "\[\[TMP_$new\]\]", $new
        }
        
        # Replace the question block
        $pos = $newContent.IndexOf($qBlock)
        if ($pos -ge 0) {
            $newContent = $newContent.Remove($pos, $qBlock.Length).Insert($pos, $newBlock)
        }
    }
    
    # Update answer key
    foreach ($qNum in $newAnswers.Keys | Sort-Object) {
        $oldAns = $answerMap[$qNum]
        $newAns = $newAnswers[$qNum]
        if ($oldAns -eq $newAns) { continue }
        
        # Find and replace in answer key table
        $pattern = "(\|\s*$qNum\s*\|\s*)$oldAns(\s*\|)"
        $replacement = "`${1}$newAns`$2"
        $newContent = $newContent -replace $pattern, $replacement
    }
    
    if (-not $DryRun) {
        $newContent | Set-Content $file.FullName -NoNewline
        Write-Host "  Rebalanced and saved" -ForegroundColor Green
    }
}

Write-Host "`nDone. Run without -DryRun to apply changes." -ForegroundColor Cyan
