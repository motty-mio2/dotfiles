#!/bin/bash

# task
if ! hash task &>/dev/null && hash go-task &>/dev/null; then
	alias task=go-task
fi

# Verilog
alias iv="iverilog"
alias ivx="iverilog -g2012"

# Others
alias doc='docker compose'
alias rsmv='\rsync -avhPR --remove-source-files'
alias wget='\wget --hsts-file=$XDG_DATA_HOME/wget-hsts'

ghf() {
	gh repo clone "$(gh repo list -L 10000 | fzf | awk '{print $1}')"
}

mygitconfig() {
	git config --local user.name "motty"
	git config --local user.email "motty.mio2@gmail.com"
}

# fonts
install-hackgen() {
	WORKDIR=$(mktemp -d)

	FONT_DIR="$XDG_DATA_HOME/fonts"

	mkdir -p "$FONT_DIR"

	for i in $(curl -s https://api.github.com/repos/yuru7/HackGen/releases/latest | grep browser_download_url | cut -d : -f 2,3 | tr -d \"); do
		url=$(echo "$i" | tr -d ' ')
		echo "$url"
		curl -sL -o "$WORKDIR/tmp.zip" "$url"

		unzip -oq "$WORKDIR/tmp.zip" -d "$FONT_DIR"
	done

	rm -rf "$WORKDIR"
}
