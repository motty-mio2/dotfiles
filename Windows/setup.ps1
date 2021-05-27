New-Item -Path '~\Documents\PowerShell' -ItemType Directory
New-Item -Path '~\Documents' -Name 'WindowsPowerShell' -Target 'PowerShell' -ItemType SymbolicLink

Copy-Item $(Join-Path $PSScriptRoot "Microsoft.PowerShell_profile.ps1") '~\Documents\PowerShell'

New-Item -ItemType SymbolicLink -Path '~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup' -Name config.xlaunch -Value $(Join-Path $PSScriptRoot "config.xlaunch")

Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease -Force
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

# winget install PowerShell --version 7.0.3
