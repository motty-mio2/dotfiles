#!/usr/bin/sh

alias aupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias bupdate='brew update && brew upgrade'
alias zupdate='sudo zypper ref && sudo zypper update -y'

alias ls="ls --color=auto"
alias ll='ls -lahGF'
alias lh='ls -ldGF .*'

alias rmrf='rm -rf'
alias watch="watch "
alias rmemp='find . -type d -empty -delete'

lsn(){
    find . -maxdepth 1 | wc -l
}


mkcd() {
    mkdir "$1" && cd "$1" || exit
}

cats() {
    < "$1" grep -vE "^\s*#" | grep -vE '^\s*$'
}

export PIPENV_VENV_IN_PROJECT=1
export LIBGL_ALWAYS_INDIRECT=1
export CUBLAS_WORKSPACE_CONFIG=:16:8
