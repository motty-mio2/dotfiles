#!/bin/bash

# Cargo
source "$HOME/.cargo/env"

# Rye
export RYE_HOME="$HOME/.local/share/rye"
source "$RYE_HOME/env"

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
