#!/usr/bin/env bash

export XDG_CONFIG_HOME="$HOME/.config"

alias aupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias bupdate='brew update && brew upgrade'
alias dupdate='sudo dnf update -y'
alias zupdate='sudo zypper ref && sudo zypper update -y'

alias ls="ls --color=auto"
alias ll='ls -lahF'
alias lh='ls -ldF .*'

alias rmrf='rm -rf'
alias watch="watch "

export PIPENV_VENV_IN_PROJECT=1

export EDITOR=nvim

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

envup() {
	dirs=("$HOME/.pyenv")

	for target in "${dirs[@]}"; do
		if [ -d "$target" ]; then
			echo "$target"
			git -C "$target" pull
		fi
	done

	rustup update
	cargo install-update --all
	sheldon lock --update
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

set-window-title() {
	local title="$1"

	if [ -z "$title" ]; then
		title=${USER}@${HOST}
	fi
	echo -ne "\033]0; $title \007"
}

set-dialout() {
	sudo usermod -aG dialout $USER
}

set-window-title
