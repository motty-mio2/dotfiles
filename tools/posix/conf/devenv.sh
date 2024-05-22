#!/bin/bash

# Brew
if [ -d "$HOME/.local/share/brew" ]; then
	eval "$("$HOME/.local/share/brew/bin/brew" shellenv)"
fi

# nix
if [ -d "$HOME/.nix-profile" ]; then
	source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Go
if [ -d "$HOME/go/bin" ]; then
	export PATH="$HOME/go/bin:$PATH"
fi

# Pyenv
if [ -d "$HOME/.pyenv" ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	if which "pyenv" >/dev/null 2>&1; then
		eval "$(pyenv init --path)"
		eval "$(pyenv init -)"
	fi
fi

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"
fi

# Rye
export RYE_HOME="$HOME/.local/share/rye"
if [ -e "$RYE_HOME/env" ]; then
	# shellcheck source=/dev/null
	source "$RYE_HOME/env"
fi

# svlint
export SVLINT_CONFIG="$HOME/.config/svls/.svlint.toml"

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

# Volta
if [ -d "$HOME/.local/share/volta" ]; then
	export VOLTA_HOME="$HOME/.local/share/volta"
	export PATH="$VOLTA_HOME/bin:$PATH"
fi

# Others
alias doc='docker compose'
alias rsmv='\rsync -avhPR --remove-source-files'

ghf() {
	gh repo clone "$(gh repo list -L 10000 | fzf | awk '{print $1}')"
}

mygitconfig() {
	git config --local user.name "motty"
	git config --local user.email "motty.mio2@gmail.com"
}
