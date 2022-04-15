New-Item -ItemType Directory -Path '~\Documents\PowerShell\conf'
Get-ChildItem -Path (Join-Path $PSScriptRoot "\conf\") -Name -Recurse | ForEach-Object -Process {
    New-Item -ItemType SymbolicLink -Path '~\Documents\PowerShell\conf\' -Name $_ -Value $(Join-Path $PSScriptRoot "conf\" $_)
}

New-Item -ItemType SymbolicLink -Path '~\Documents' -Name 'WindowsPowerShell' -Target (Join-Path $HOME '\Documents\PowerShell')

Copy-Item $(Join-Path $PSScriptRoot "Microsoft.PowerShell_profile.ps1") '~\Documents\PowerShell'

New-Item -ItemType SymbolicLink -Path '~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup' -Name config.xlaunch -Value $(Join-Path $PSScriptRoot "config.xlaunch")

Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease -Force
Install-Module PSReadLine -Scope CurrentUser -AllowPrerelease -Force
