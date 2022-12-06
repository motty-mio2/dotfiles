#!/bin/bash

script_directory=$(cd $(dirname $0); pwd)

# install packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# nvim config directory
conf_directory="$HOME/.config/nvim"

ln -s "${script_directory}/config" "${conf_directory}"

