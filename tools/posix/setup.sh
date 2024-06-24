#!/usr/bin/bash

eval "$(curl -s https://raw.githubusercontent.com/motty-mio2/dotfiles/main/dot_profile)"
eval "$(curl -s https://raw.githubusercontent.com/motty-mio2/dotfiles/main/tools/posix/conf/devtools.sh)"

if type "pacman" >/dev/null 2>&1; then
	install-arch-tools

else
	if type "apt" >/dev/null 2>&1; then
		echo "Ubuntu Mode"
		#     sudo sed -i.org -e 's|archive.ubuntu.com|ftp.jaist.ac.jp/pub/Linux|g' /etc/apt/sources.list
		install-debian-tools
	elif type "dnf" >/dev/null 2>&1; then
		echo "RHEL Mode"
		sudo dnf -q -y groupinstall "Development Tools"
		# Pyenv dependency
		if [ -f "/etc/fedora-release" ]; then
			sudo dnf -q -y install make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-devel libnsl2-devel
		else
			sudo yum -q -y install gcc make patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel python39
		fi

	elif type "zypper" >/dev/null 2>&1; then
		zypper install gcc automake bzip2 libbz2-devel xz xz-devel openssl-devel ncurses-devel \
			readline-devel zlib-devel tk-devel libffi-devel sqlite3-devel libgdbm-devel make findutils
	else
		echo "None"
	fi

	#!/bin/bash

	echo -n "Use nix or brew [N/b]: "
	read -r ANS

	case $ANS in
	"" | [Nn]*)
		# Use nix pm
		install-nix
		;;

	*)
		# Use Linux Brew
		install-homebrew

		install-homebrew-tools
		;;
	esac
fi

# Use chezmoi
chezmoi init motty-mio2
chezmoi apply -k
chezmoi apply -k
