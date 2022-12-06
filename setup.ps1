# install packer.nvim
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

# nvim config directory
New-Item -ErrorAction Ignore -ItemType Directory -Path '~\AppData\Local\'

New-Item -ErrorAction Ignore -ItemType SymbolicLink -Path '~\AppData\Local\' -Name 'nvim' -Value $(Join-Path $PSScriptRoot "\config\")

