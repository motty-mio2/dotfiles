New-Item -ErrorAction Ignore -ItemType Directory -Path '~\AppData\Local\nvim'

New-Item -ItemType SymbolicLink -Path '~\AppData\Local\nvim' -Name 'init.lua' -Value $(Join-Path $PSScriptRoot "\config\init.lua")

New-Item -ItemType SymbolicLink -Path $HOME -Name ".vim" -Value $(Join-Path $PSScriptRoot "\config\vim")
