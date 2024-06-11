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

ghf() {
	gh repo clone "$(gh repo list -L 10000 | fzf | awk '{print $1}')"
}

mygitconfig() {
	git config --local user.name "motty"
	git config --local user.email "motty.mio2@gmail.com"
}

# fonts
install-hackgen() {
	array=()
	WORKDIR="$HOME/tmp/hackgen"
	mapfile -t array < <(curl -s https://api.github.com/repos/yuru7/HackGen/releases/latest | grep browser_download_url | cut -d : -f 2,3 | tr -d \")

	mkdir -p "$HOME/.fonts"

	mkdir -p "$WORKDIR"
	cd "$WORKDIR" || exit

	for i in "${array[@]}"; do
		url=$(echo "$i" | tr -d ' ')
		echo "$url"
		curl -sL -o ./tmp.zip "$url"

		unzip -oq ./tmp.zip
		rm ./tmp.zip
	done

	for a in ./*; do
		di=$(echo "$a" | cut -d / -f 2)
		echo "$di"
		cp -r "$WORKDIR/$di/"* "$HOME/.fonts/"
	done

	rm -rf "$WORKDIR"
}
