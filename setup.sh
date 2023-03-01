#!/bin/bash

script_directory=$(cd $(dirname $0); pwd)

# nvim config directory
conf_directory="$HOME/.config/nvim"

ln -s "${script_directory}/config" "${conf_directory}"

