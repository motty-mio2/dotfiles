Get-ChildItem -Path (Join-Path $PSScriptRoot "\conf") -Name -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + (Join-Path $PSScriptRoot "\conf") + $_)
}
