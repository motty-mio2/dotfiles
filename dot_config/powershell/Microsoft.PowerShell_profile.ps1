$configure_folder = $HOME + "\.config\powershell"

Get-ChildItem -Path ("$configure_folder\conf") -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + $_)
}

Get-ChildItem -Path ("$configure_folder\completion") -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + $_)
}
