param(
    [String]$FilePath
)

# Read the entire content of the file as a single string
$content = Get-Content -Path $FilePath -Raw

# Replace occurrences of two or more consecutive Windows-style newline characters with a single Windows-style newline
$newContent = $content -replace '(\r\n){2,}', "`r`n"

# Replace occurrences of two or more consecutive spaces with a single space
$newContent = $newContent -replace ' {2,}', ' '

# Write the modified content back to the original file
Set-Content -Path $FilePath -Value $newContent

Write-Host "Processed $FilePath"
