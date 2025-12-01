#!/usr/bin/env bash

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ls="ls --color=auto"
alias ll='ls -lahF'
alias lh='ls -ldF .*'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias rmrf='rm -rf'
alias rsmv='\rsync -avhPR --remove-source-files'
alias watch="watch "
alias wget='\wget --hsts-file=$XDG_DATA_HOME/wget-hsts'

# Others
alias doc='docker compose'
alias pchezmoi='chezmoi -S $HOME/Projects/dotfiles'

# Verilog
alias iv="iverilog"
alias ivx="iverilog -g2012"

# Vim
alias vim='VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc" vim'

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

ghf() {
	gh repo clone "$(gh repo list -L 10000 | fzf | awk '{print $1}')"
}

set-window-title() {
	local title="$1"

	if [ -z "$title" ]; then
		title=${USER}@${HOST}
	fi
	echo -ne "\033]0; $title \007"
}
