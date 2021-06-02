SCRIPT_DIR=$(cd $(dirname $0); pwd)
source "${SCRIPT_DIR}/shell.sh"

plugins=(git zsh-autosuggestions zsh-completions)

fpath=(/usr/local/share/zsh-completions/src $fpath)

autoload -Uz compinit && compinit
autoload -Uz colors
colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
PROMPT="%{${fg[green]}%}[%n@%m]%{${fg[yellow]}%}(%*%) %{${fg[blue]}%}%~ %# %{${reset_color}%}"
