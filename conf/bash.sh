#!/bin/bash

conf_folder="${HOME}/conf"
if [ -d "$conf_folder" ]; then
    for file in $( ls "$conf_folder" | grep .sh$ ); do
        source "${conf_folder}/${file}"
    done
fi


#if [ -n "$BASH_VERSION" ]; then
#    # include .bashrc if it exists
#   if [ -f "$HOME/.bashrc" ]; then
#    . "$HOME/.bashrc"
#    fi
#fi

