#!/bin/bash

script_directory=$(cd $(dirname $0); pwd)

# install packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# nvim config directory
conf_directory="$HOME/.config/nvim"
mkdir -p "$conf_directory"

ln -s "${script_directory}/config/vim" "${HOME}/.vim"
ln -s "${script_directory}/config/init.lua" "${conf_directory}/init.lua"


mkdir -p ~/.cache/dein
cd ~/.cache/dein || exit

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

brew install zk # markdown
node install --location=global pyright # Python
cargo install svls # SystemVerilog
