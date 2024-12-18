#!/usr/bin/env bash

alias aupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias bupdate='brew update && brew upgrade'
alias dupdate='sudo dnf update -y'
alias pupdate='sudo pacman -Syu'
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
		nix flake update --flake "$(chezmoi source-path)/$item"
		nix profile upgrade "$item"
	done

}

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

set-window-title() {
	local title="$1"

	if [ -z "$title" ]; then
		title=${USER}@${HOST}
	fi
	echo -ne "\033]0; $title \007"
}

set-window-title
