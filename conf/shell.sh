#!/bin/bash
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

alias ll='ls -la'
alias aupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias bupdate='brew update && brew upgrade'
alias pip='pip3'
alias python='python3'
alias rmrf='rm -rf'

function mkcd() {
    mkdir $1 && cd $_
}

function cats() {
    cat $1 | grep -vE "^#" | grep -vE "^( )*#" | grep -vE '^\s*$'
}

export PIPENV_VENV_IN_PROJECT=1
export LIBGL_ALWAYS_INDIRECT=1
export CUBLAS_WORKSPACE_CONFIG=:16:8
