$configure_folder = Split-Path $profile -Parent

Get-ChildItem -Path (Join-Path $configure_folder "\conf\") -Name -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + (Join-Path $configure_folder "\conf\") + $_)
}


$addon_folder = (Join-Path $configure_folder "\addon\")
if (Test-Path $addon_folder) {
    Get-ChildItem -Path $addon_folder -Name -Recurse -Include *.ps1 | ForEach-Object -Process {
        Invoke-Expression (". " + $addon_folder + $_)
    }
}