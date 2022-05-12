#!/usr/bin/zsh

conf_folder="${HOME}/conf"
if [ -d "$conf_folder" ]; then
    source "${conf_folder}"/*.sh
fi

fpath=(/usr/local/share/zsh-completions/src "$fpath")

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
#SAVEHIST=10000
zstyle ':prezto:module:prompt' theme 'powerlevel10k'

autoload -Uz promptinit
promptinit
prompt powerlevel10k

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

