#!/bin/bash

# Brew
if [ -d "$BREW_PREFIX" ]; then
	eval "$("$BREW_PREFIX/bin/brew" shellenv)"
fi

# Pyenv
if [ -d "$PYENV_ROOT" ]; then
	if which "pyenv" >/dev/null 2>&1; then
		eval "$(pyenv init --path)"
		eval "$(pyenv init -)"
	fi
fi

# task
if ! hash task &>/dev/null && hash go-task &>/dev/null; then
	alias task=go-task
fi

# Verilog
alias iv="iverilog"
alias ivx="iverilog -g2012"

# Verilog
alias iv="iverilog"
alias ivx="iverilog -g2012"

# Others
alias doc='docker compose'
alias rsmv='\rsync -avhPR --remove-source-files'
