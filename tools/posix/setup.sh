#!/usr/bin/bash

eval "$(curl -s https://raw.githubusercontent.com/motty-mio2/dotfiles/main/tools/posix/conf/devtools.sh)"
eval "$(curl -s https://raw.githubusercontent.com/motty-mio2/dotfiles/main/dot_profile)"

if type "pacman" >/dev/null 2>&1; then
	sudo pacman -Sy --noconfirm --needed base-devel git go openssl tk xz zlib
	git clone https://aur.archlinux.org/yay.git
	cd yay || exit
	makepkg --noconfirm -si
	yay -Sy --noconfirm bat byobu chezmoi curl fd fzf git github-cli go \
		htop jq nano neovim \
		oh-my-posh pkg-config screen sheldon starship tree ttf-hackgen unarchiver unzip \
		wget zsh

	# Use chezmoi
	chezmoi init motty-mio2
	chezmoi apply -k
	chezmoi apply -k

else
	if type "apt" >/dev/null 2>&1; then
		echo "Ubuntu Mode"
		#     sudo sed -i.org -e 's|archive.ubuntu.com|ftp.jaist.ac.jp/pub/Linux|g' /etc/apt/sources.list
		sudo add-apt-repository ppa:longsleep/golang-backports
		sudo apt-get update
		sudo apt-get upgrade -qy
		sudo apt-get install -qy byobu curl git nano screen unar wget zsh libssl-dev build-essential golang
		# Pyenv Dependency
		sudo apt-get install -y \
			build-essential curl llvm make tk-dev xz-utils wget \
			libbz2-dev libffi-dev liblzma-dev libncursesw5-dev libreadline-dev \
			libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev zlib1g-dev \
			python3-dev python3-venv python-is-python3

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
		sh <(curl -L https://nixos.org/nix/install) --no-daemon
		;;

	*)
		# Use Linux Brew
		BREW_PREFIX="$HOME/.local/share/brew"
		mkdir "$BREW_PREFIX"
		curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip-components 1 -C "$BREW_PREFIX"

		eval "$("$BREW_PREFIX"/bin/brew shellenv)"
		brew install chezmoi
		chezmoi init motty-mio2
		chezmoi apply -k
		chemzoi apply -k

		;;
	esac

	# Use chezmoi
fi
