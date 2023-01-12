#!/usr/bin/env bash

export XDG_CONFIG_HOME="$HOME/.config"

# Rust
if [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
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

envup () {
    dirs=("$HOME/Projects/dotfiles" "$HOME/Projects/dotprivate" "$HOME/Projects/poshconfig" "$HOME/Projects/nvimcfg" "$HOME/.pyenv")
    
    for target in "${dirs[@]}"
    do
        if [ -d "$target" ] ; then
            echo "$target"
            git -C "$target" pull
        fi
    done
    
    cargo install-update --all
    sheldon lock --update
}

webp2png (){
    while [[ "${1:-}" = -* ]]; do shift; done
    
    if [ $# -gt 0 ]; then
        for file in "$1"/*.webp ; do
            echo "$file"
            output_name="${file%webp}png"
            dwebp -mt "${file}" -o "$output_name"
        done
    fi
}

png2webp (){
    while [[ "${1:-}" = -* ]]; do shift; done
    
    if [ $# -gt 0 ]; then
        for file in "$1"/*.png ; do
            echo "$file"
            output_name="${file%png}webp"
            cwebp  -lossless -mt -quiet "${file}" -o "$output_name"
        done
    fi
}

export PIPENV_VENV_IN_PROJECT=1
export LIBGL_ALWAYS_INDIRECT=1
export CUBLAS_WORKSPACE_CONFIG=:16:8
