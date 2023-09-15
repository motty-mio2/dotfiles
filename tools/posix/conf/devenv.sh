#!/bin/bash

# Brew
if [ -d "/home/linuxbrew/" ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Go
if [ -d "$HOME/go/bin" ]; then
	export PATH="$HOME/go/bin:$PATH"
fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which "pyenv" >/dev/null 2>&1; then
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
fi

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"           # old
export PATH="$HOME/.local/share/pypoetry:$PATH" # new

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"
fi

# Rye
export RYE_HOME="$HOME/.local/share/rye"
if [ -d "$RYE_HOME" ]; then
	# shellcheck source=/dev/null
	source "$RYE_HOME/env"
fi

# svlint
export SVLINT_CONFIG="$HOME/.config/svls/.svlint.toml"

# Verilog
alias iv="iverilog"
alias ivx="iverilog -g2012"

# Verilog
alias iv="iverilog"
alias ivx="iverilog -g2012"

# Volta
export VOLTA_HOME="$HOME/.local/share/volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Others
alias doc='docker compose'
alias rsmv='\rsync -avhPR --remove-source-files'

ghf() {
	gh repo clone "$(gh repo list -L 10000 | fzf | awk '{print $1}')"
}
