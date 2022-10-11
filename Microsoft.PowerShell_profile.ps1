$configure_folder = Split-Path $profile -Parent

Get-ChildItem -Path ($configure_folder + "\conf\") -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + $_)
}
