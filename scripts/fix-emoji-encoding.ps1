# fix-emoji-encoding.ps1
# Byte-level emoji fix for wrong-answer files
param([switch]$DryRun)

$root = Split-Path -Parent $PSScriptRoot
Write-Host "=== Emoji Byte Fix ===" -ForegroundColor Cyan
if ($DryRun) { Write-Host "DRY RUN" -ForegroundColor Yellow }

# Replacements: @(garbledBytes, correctBytes)
$reps = @(
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE5,0xB8,0xB3,0xE9,0xA6,0x83,0xE5,0xB8,0xB3,0xE9,0xA6,0x83,0xE5,0xB8,0xB3), [byte[]]@(0xF0,0x9F,0x8E,0xA4,0xF0,0x9F,0x8E,0xA4,0xF0,0x9F,0x8E,0xA4))
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE5,0xB8,0xB3,0xE9,0xA6,0x83,0xE5,0xB8,0xB3), [byte[]]@(0xF0,0x9F,0x8E,0xA4,0xF0,0x9F,0x8E,0xA4))
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE5,0xB8,0xB3), [byte[]]@(0xF0,0x9F,0x8E,0xA4))
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE7,0x85,0x9D), [byte[]]@(0xF0,0x9F,0x94,0xB4))
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE7,0x85,0x9B), [byte[]]@(0xF0,0x9F,0x9F,0xA1))
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE6,0x95,0xB6), [byte[]]@(0xF0,0x9F,0x9F,0xA2))
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE6,0x91,0x89), [byte[]]@(0xF0,0x9F,0x93,0x96))
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE6,0x90,0xB5), [byte[]]@(0xF0,0x9F,0x93,0x8B))
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE6,0x94,0xA2), [byte[]]@(0xF0,0x9F,0x94,0x80))
    ,@([byte[]]@(0xE9,0xA6,0x83,0xE6,0xA4,0x87,0xE9,0x8D,0x94,0x3F), [byte[]]@(0xF0,0x9F,0x97,0xBA,0xEF,0xB8,0x8F))
)

$files = Get-ChildItem "$root\[0-9]*.md" | Where-Object { $_.Name -match '^\d+\.md$' }
$cnt = 0

foreach ($f in $files) {
    $b = [System.IO.File]::ReadAllBytes($f.FullName)
    $mod = $false
    foreach ($r in $reps) {
        $old = $r[0]; $new = $r[1]
        # Search for sequence
        $pos = 0
        :search while ($pos -le $b.Length - $old.Length) {
            $match = $true
            for ($j=0; $j -lt $old.Length; $j++) {
                if ($b[$pos+$j] -ne $old[$j]) { $match = $false; break }
            }
            if ($match) {
                if (-not $DryRun) {
                    # Replace inline
                    $newB = [byte[]]::new($b.Length - $old.Length + $new.Length)
                    [Array]::Copy($b, 0, $newB, 0, $pos)
                    [Array]::Copy($new, 0, $newB, $pos, $new.Length)
                    [Array]::Copy($b, $pos+$old.Length, $newB, $pos+$new.Length, $b.Length-$pos-$old.Length)
                    $b = $newB
                }
                $mod = $true
                $pos += $new.Length
                if ($DryRun) { break search }
                continue search
            }
            $pos++
        }
    }
    if ($mod) {
        if (-not $DryRun) {
            [System.IO.File]::WriteAllBytes($f.FullName, $b)
        }
        $cnt++
        Write-Host "FIXED: $($f.Name)" -ForegroundColor Green
    }
}

Write-Host "`nFiles fixed: $cnt" -ForegroundColor Cyan
if ($DryRun) { Write-Host "Rerun without -DryRun to apply" -ForegroundColor Yellow }
