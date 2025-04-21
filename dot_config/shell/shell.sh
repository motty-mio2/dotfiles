#!/usr/bin/env bash

alias aupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias bupdate='brew update && brew upgrade'
alias dupdate='sudo dnf update -y'
alias fupdate='sudo flatpak update && sudo flatpak remove --unused'
alias pupdate='sudo pacman -Syu'
alias supdate='sudo snap refresh'
alias yupdate='yay -Syu'
alias zupdate='sudo zypper ref && sudo zypper update -y'

alias ls="ls --color=auto"
alias ll='ls -lahF'
alias lh='ls -ldF .*'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias rmrf='rm -rf'
alias watch="watch "

nupdate() {
	for item in $(nix profile list --json | jq -r ".elements | keys | .[] "); do
		nix flake update --flake "$XDG_DATA_HOME/nix/$item"
		nix profile upgrade "$item"
	done

}

#!/usr/bin/bash

rmemp() {
	local target_directory="$1"

	if [ -z "$target_directory" ]; then
		target_directory="."
	fi

	find "$target_directory" -type d -empty -delete
}

lsn() {
	find . -maxdepth 1 | wc -l
}

mkcd() {
	mkdir "$1" && cd "$1" || exit
}

cats() {
	grep <"$1" -vE "^\s*#" | grep -vE '^\s*$'
}

webp2png() {
	while [[ "${1:-}" = -* ]]; do shift; done

	if [ $# -gt 0 ]; then
		for file in "$1"/*.webp; do
			echo "$file"
			output_name="${file%webp}png"
			dwebp -mt "${file}" -o "$output_name"
		done
	fi
}

png2webp() {
	while [[ "${1:-}" = -* ]]; do shift; done

	if [ $# -gt 0 ]; then
		for file in "$1"/*.png; do
			echo "$file"
			output_name="${file%png}webp"
			cwebp -lossless -mt -quiet "${file}" -o "$output_name"
		done
	fi
}

bwx() {
	output=$(bw unlock)

	echo "$output" | while IFS= read -r line; do
		case "$line" in
		\$\ *)
			eval "${line#\$ }"
			break
			;;
		esac
	done
}

# Others
alias pchezmoi='chezmoi -S $HOME/Projects/dotfiles'

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

# task
if ! hash task &>/dev/null && hash go-task &>/dev/null; then
	alias task=go-task
fi

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

set-window-title() {
	local title="$1"

	if [ -z "$title" ]; then
		title=${USER}@${HOST}
	fi
	echo -ne "\033]0; $title \007"
}
