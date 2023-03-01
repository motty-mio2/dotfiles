# nvim config directory
New-Item -ErrorAction Ignore -ItemType Directory -Path '~\AppData\Local\'

New-Item -ErrorAction Ignore -ItemType SymbolicLink -Path '~\AppData\Local\' -Name 'nvim' -Value $(Join-Path $PSScriptRoot "\config\")

