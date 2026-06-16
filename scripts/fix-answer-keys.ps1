# fix-answer-keys.ps1
# ⚠️ DEPRECATED — DO NOT USE. This script was an early attempt at fixing the mock exam
# answer distribution B-bias. It corrupted files due to PowerShell 5.1 encoding issues.
# Mock exams were manually fixed instead. Kept for historical reference only.
# Purpose: Rescan each mock exam question and fix the answer key to match actual correct option
# Reads question content, identifies correct answer, updates answer key table ONLY
# Usage: .\scripts\fix-answer-keys.ps1

param([string]$TargetFile = "")

$root = Split-Path -Parent $PSScriptRoot
$practiceDir = "$root\practice"

# For each exam, define the ACTUAL correct answer for each question
# (manually determined from question content - these are the known correct answers)
$correctAnswers = @{
    "Mock-Exam-A" = @{
        1='B'; 2='B'; 3='B'; 4='A'; 5='B,C'; 6='B'; 7='B'; 8='B'; 9='B'; 10='B'
        11='B'; 12='B'; 13='C'; 14='D'; 15='A'; 16='A'; 17='B'; 18='B'; 19='B'; 20='B'
        21='C'; 22='B'; 23='A,D'; 24='C'; 25='C'; 26='C'; 27='B'; 28='D'; 29='C'
        30='B'; 31='A'; 32='B'; 33='B'; 34='A'; 35='C'; 36='A'; 37='B'; 38='B'; 39='B'; 40='B'
        41='C'; 42='C'; 43='A,C'; 44='B'; 45='D'; 46='B'; 47='C'; 48='B'; 49='B'; 50='C'
        51='B'; 52='B'; 53='B'; 54='B'; 55='B'; 56='A,C'; 57='B'; 58='A'; 59='A'; 60='A,B'
        61='A'; 62='B'; 63='C'; 64='B'; 65='A'; 66='C'; 67='B'; 68='B'; 69='C'; 70='B'
        71='A'; 72='A'; 73='B'; 74='B'; 75='B'
    }
}

Write-Host "=== Answer Key Fixer ===" -ForegroundColor Cyan

$files = if ($TargetFile) {
    Get-ChildItem "$practiceDir\$TargetFile" -ErrorAction SilentlyContinue
} else {
    Get-ChildItem "$practiceDir\Mock-Exam-*.md" | Sort-Object Name
}

foreach ($file in $files) {
    $examName = $file.BaseName
    if (-not $correctAnswers.ContainsKey($examName)) {
        Write-Host "Skipping $examName — no correction map defined" -ForegroundColor Yellow
        continue
    }
    
    $answers = $correctAnswers[$examName]
    $content = Get-Content $file.FullName -Raw
    
    # Count current distribution before fix
    $beforeDist = @{}
    $keyLines = $content -split "`n" | Where-Object { $_ -match '^\|\s*(\d+)\s*\|\s*([A-E](?:,\s*[A-E])?)\s*\|' }
    foreach ($line in $keyLines) {
        if ($line -match '^\|\s*(\d+)\s*\|\s*([A-E](?:,\s*[A-E])?)\s*\|') {
            $ans = $matches[2]
            $beforeDist[$ans] = ($beforeDist[$ans] ?? 0) + 1
        }
    }
    
    # Fix each answer key entry
    $newContent = $content
    foreach ($qNum in ($answers.Keys | Sort-Object)) {
        $correctAns = $answers[$qNum]
        
        # Update all entries for this question number
        $pattern = "(\|\s*$qNum\s*\|\s*)[A-E](?:,\s*[A-E])?(\s*\|)"
        $replacement = "`${1}$correctAns`$2"
        $newContent = $newContent -replace $pattern, $replacement
    }
    
    # Count distribution after fix
    $afterDist = @{}
    $keyLines2 = $newContent -split "`n" | Where-Object { $_ -match '^\|\s*(\d+)\s*\|\s*([A-E](?:,\s*[A-E])?)\s*\|' }
    foreach ($line in $keyLines2) {
        if ($line -match '^\|\s*(\d+)\s*\|\s*([A-E](?:,\s*[A-E])?)\s*\|') {
            $ans = $matches[2]
            $afterDist[$afterDist.Count] = $ans  # Just counting
        }
    }
    
    $newContent | Set-Content $file.FullName -NoNewline
    Write-Host "$examName : Fixed $($answers.Count) answers" -ForegroundColor Green
}

Write-Host "`nDone." -ForegroundColor Cyan
