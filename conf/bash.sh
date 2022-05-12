#!/bin/bash

conf_folder="${HOME}/conf"
if [ -d "$conf_folder" ]; then
    source "${conf_folder}"/*.sh
fi


#if [ -n "$BASH_VERSION" ]; then
#    # include .bashrc if it exists
#   if [ -f "$HOME/.bashrc" ]; then
#    . "$HOME/.bashrc"
#    fi
#fi

