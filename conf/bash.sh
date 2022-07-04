#!/usr/bin/bash

conf_folder="${HOME}/conf"
if [ -d "$conf_folder" ]; then
    for file in "$conf_folder"/*.sh; do
        source "${file}"
    done
fi


#if [ -n "$BASH_VERSION" ]; then
#    # include .bashrc if it exists
#   if [ -f "$HOME/.bashrc" ]; then
#    . "$HOME/.bashrc"
#    fi
#fi

