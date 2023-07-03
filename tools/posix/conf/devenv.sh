#!/bin/sh

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Poetry
export PATH="$HOME/.poetry/bin:$PATH" # old
export PATH="$HOME/.local/share/pypoetry:$PATH" # new

# rye
rye_folder="$HOME/.rye/env"
if [ -d "$rye_folder" ]
then
    source "${rye_folder}"
fi
# svlint
export SVLINT_CONFIG="$HOME/.config/svls/.svlint.toml"

# Verilog
alias iv="iverilog"
alias ivx="iverilog -g2012"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

alias doc='docker compose'
alias rsmv='\rsync -avhPR --remove-source-files'

ghf () {
    gh repo clone "$(gh repo list -L 10000 | fzf | awk '{print $1}' )"
}
