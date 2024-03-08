# charcount.ps1
param(
    [String]$FilePath,
    [Int]$MaxInstructionsLength = 8000,
    [Int]$MaxDescriptionLength = 300
)

$content = Get-Content -Path $FilePath -Raw
$contentLength = $content.Length

if ($FilePath -match 'GPT-instructions' -and $contentLength -gt $MaxInstructionsLength) {
    Write-Host "$FilePath: TOO LONG ($contentLength characters, max $MaxInstructionsLength)"
} elseif ($FilePath -eq 'GPT-description.txt' -and $contentLength -gt $MaxDescriptionLength) {
    Write-Host "$FilePath: TOO LONG ($contentLength characters, max $MaxDescriptionLength)"
} else {
    Write-Host "$FilePath: OK ($contentLength characters)"
}

