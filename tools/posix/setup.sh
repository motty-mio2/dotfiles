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

	elif type "zypper" >/dev/null 2>&1; then
		zypper install -t pattern devel_basis
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
