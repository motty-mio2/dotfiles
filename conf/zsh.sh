#!/bin/zsh

export ZSH="/home/kouki/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source "${SCRIPT_DIR}/shell.sh"

plugins=(git zsh-autosuggestions zsh-completions)

fpath=(/usr/local/share/zsh-completions/src $fpath)

autoload -Uz compinit
compinit
autoload -Uz colors
colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "%F{red} *" # %u
zstyle ':vcs_info:git:*' stagedstr "%F{red} +" # %c
zstyle ':vcs_info:git:*' formats '%F{red}(%b%u%c) '

setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

PROMPT="%{${fg[green]}%}[%n@%m] %{${fg[yellow]}%}(%*%) %{${fg[blue]}%}%~ %{${fg[red]}%}\${vcs_info_msg_0_}%{${reset_color}%}%# "