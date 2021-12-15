#!/bin/zsh
conf_folder="${HOME}/conf"
if [ -d $conf_folder ]; then
    for file in $( ls $conf_folder | grep .sh$ ); do
        source "${conf_folder}/${file}"
    done
fi

fpath=(/usr/local/share/zsh-completions/src $fpath)

autoload -Uz compinit
compinit
autoload -Uz colors
colors
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt TRANSIENT_RPROMPT
setopt EXTENDED_GLOB

setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
zstyle ':prezto:module:prompt' theme 'powerlevel10k'

autoload -Uz promptinit
promptinit
prompt powerlevel10k

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

