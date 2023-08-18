$env:EDITOR = "nvim"
$env:DISPLAY = "localhost:0.0"

# $env:Path = "$HOME\bin;" + $env:Path
# try {
#     $ENV:COMSPEC = (Get-Command pwsh -ErrorAction Stop).Definition
# }
# catch {
#     $ENV:COMSPEC = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.EXE"
# }

$private_folder = $HOME + "\.config\shell\dotprivate\addon"
Get-ChildItem -Path ($private_folder) -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + $_)
}

$private_folder = $HOME + "\.config\shell\private"
Get-ChildItem -Path ($private_folder) -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + $_)
}
