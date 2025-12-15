$pattern = "import 'package:dental_link"
$replacement = "import 'package:dental_pt"

Get-ChildItem -Path "$PSScriptRoot\lib" -Include "*.dart" -Recurse | ForEach-Object {
    $file = $_
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -match [regex]::Escape($pattern)) {
        $newContent = $content -replace [regex]::Escape($pattern), $replacement
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Updated: $($file.Name)"
    }
}

Write-Host "All imports updated successfully!"
