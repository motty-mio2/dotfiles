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

alias rsmv='\rsync -avhPR --remove-source-files'
alias wget='\wget --hsts-file=$XDG_DATA_HOME/wget-hsts'

# Vim
alias vim='VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc" vim'

mkcd() {
	mkdir "$1" && cd "$1" || exit
}

bwx() {
	local key cmd

	key=$(bw unlock --raw) || return

	if [ -z "$key" ]; then
		echo "bw unlock failed." >&2
		return 1
	fi

	if [ -n "${ZSH_VERSION:-}" ]; then
		print -z "export BW_SESSION='$key'"
	elif [ -n "${BASH_VERSION:-}" ]; then
		cmd="export BW_SESSION='$key'"
		history -s "$cmd"
		printf 'Added to history. Press Up then Enter: %s\n' "$cmd"
	else
		printf "export BW_SESSION='%s'\n" "$key"
	fi
}

set-window-title() {
	local title="$1"

	if [ -z "$title" ]; then
		title=${USER}@${HOST}
	fi
	echo -ne "\033]0; $title \007"
}
