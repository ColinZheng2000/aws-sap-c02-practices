# fix-answers-v2.ps1 (UTF-8 BOM saved, no emoji in regex)
# Swaps option letters in questions to balance answer distribution
$practiceDir = "c:\Users\FengC\Documents\AWS SAP C02 202510\practice"

# Correct answers for Mock A (verified against original question content)
$mockA_answers = @{}
# Q1-Q50: original correct answers from when file was first created
$correct = @(
    'B','B','B','A','B,C','B','B','B','B','B',
    'B','B','C','D','A','A','B','B','B','B',
    'C','B','A,D','C','C','C','B','D','C',
    'B','A','B','B','A','C','A','B','B','B','B',
    'C','C','A,C','B','D','B','C','B','B','C',
    'B','B','B','B','B','A,C','B','A','A','A,B',
    'A','B','C','B','A','C','B','B','C','B',
    'A','A','B','B','B'
)
for ($i = 0; $i -lt $correct.Count; $i++) {
    $mockA_answers[$($i+1)] = $correct[$i]
}

function Fix-Exam {
    param($fileName, $correctMap)
    
    $filePath = "$practiceDir\$fileName"
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    # Build swap plan: four patterns for balance
    $swaps = @('B_to_A','B_to_C','B_to_D','keep')
    $swapIdx = 0
    $plan = @{}
    $newAnswers = @{}
    
    foreach ($q in ($correctMap.Keys | Sort-Object {[int]$_})) {
        $ans = $correctMap[$q]
        if ($ans -match ',') { $newAnswers[$q] = $ans; continue }  # multi-letter
        
        if ($ans -eq 'B') {
            $s = $swaps[$swapIdx % 4]
            $swapIdx++
            switch ($s) {
                'B_to_A' { $newAnswers[$q] = 'A'; $plan[$q] = 'swap_BA' }
                'B_to_C' { $newAnswers[$q] = 'C'; $plan[$q] = 'swap_BC' }
                'B_to_D' { $newAnswers[$q] = 'D'; $plan[$q] = 'swap_BD' }
                'keep'   { $newAnswers[$q] = 'B'; $plan[$q] = 'keep' }
            }
        } else {
            $newAnswers[$q] = $ans
            $plan[$q] = 'keep'
        }
    }
    
    # Apply swaps to question text
    $qPattern = "(?s)(### Q(\d+)\r?\n.*?)(?=\r?\n### Q\d+|\r?\n---\r?\n# Part B)"
    $qMatches = [regex]::Matches($content, $qPattern)
    
    for ($i = $qMatches.Count - 1; $i -ge 0; $i--) {
        $m = $qMatches[$i]
        $qNum = [int]$m.Groups[2].Value
        $qBlock = $m.Groups[1].Value
        
        if (-not $plan.ContainsKey($qNum)) { continue }
        $p = $plan[$qNum]
        
        $newBlock = $qBlock
        switch ($p) {
            'swap_BA' {
                $newBlock = $newBlock -replace '- A\.', '- [SWAP_TMP].'
                $newBlock = $newBlock -replace '- B\.', '- A.'
                $newBlock = $newBlock -replace '- \[SWAP_TMP\]\.', '- B.'
            }
            'swap_BC' {
                $newBlock = $newBlock -replace '- B\.', '- [SWAP_TMP].'
                $newBlock = $newBlock -replace '- C\.', '- B.'
                $newBlock = $newBlock -replace '- \[SWAP_TMP\]\.', '- C.'
            }
            'swap_BD' {
                $newBlock = $newBlock -replace '- B\.', '- [SWAP_TMP].'
                $newBlock = $newBlock -replace '- D\.', '- B.'
                $newBlock = $newBlock -replace '- \[SWAP_TMP\]\.', '- D.'
            }
        }
        
        $pos = $content.IndexOf($qBlock)
        if ($pos -ge 0) {
            $content = $content.Remove($pos, $qBlock.Length).Insert($pos, $newBlock)
        }
    }
    
    # Fix answer key table
    foreach ($q in ($newAnswers.Keys | Sort-Object {[int]$_})) {
        $newAns = $newAnswers[$q]
        $pattern = "(\| $q \| )\S+?( \|)"
        $replacement = "`$1$newAns`$2"
        $content = $content -replace $pattern, $replacement
    }
    
    # Show distribution
    $dist = @{}
    foreach ($q in ($newAnswers.Keys | Sort-Object {[int]$_})) {
        $a = $newAnswers[$q]
        if ($a -match ',') { continue }
        if (-not $dist.ContainsKey($a)) { $dist[$a] = 0 }
        $dist[$a] = $dist[$a] + 1
    }
    $dStr = ($dist.Keys | Sort-Object | ForEach-Object { "$_=$($dist[$_])" }) -join " "
    Write-Host "  $fileName : $dStr" -ForegroundColor Green
    
    [System.IO.File]::WriteAllText($filePath, $content, [System.Text.UTF8Encoding]::new($false))
}

Write-Host "=== Answer Fix v2 ===" -ForegroundColor Cyan

# Fix Mock A
Fix-Exam "Mock-Exam-A.md" $mockA_answers

Write-Host "Done. Mock A fixed with balanced distribution." -ForegroundColor Green
