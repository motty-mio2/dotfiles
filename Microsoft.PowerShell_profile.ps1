$configure_folder = Split-Path $profile -Parent

Get-ChildItem -Path (Join-Path $configure_folder "\conf\") -Name -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + (Join-Path $configure_folder "\conf\") + $_)
}
