#!/bin/zsh
SCRIPT_DIR=$(cd $(dirname $0); pwd)
source "${SCRIPT_DIR}/shell.sh"

fpath=(/usr/local/share/zsh-completions/src $fpath)

autoload -Uz compinit
compinit
autoload -Uz colors
colors
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt TRANSIENT_RPROMPT

setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

zstyle ':prezto:module:prompt' theme 'powerlevel10k'

autoload -Uz promptinit
promptinit
prompt powerlevel10k