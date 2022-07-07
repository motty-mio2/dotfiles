#!/usr/bin/sh

conf_directory="${HOME}/.conf/shell"

if [ -d "$conf_directory" ]; then
    for file in $( ls "$conf_directory" | grep .sh$ ); do
        source "${conf_directory}/${file}"
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

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

