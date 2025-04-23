#!/usr/bin/env bash

# Install Package Manager

install-deno() {
	curl -fsSL https://deno.land/install.sh | sh
}

install-rust() {
	curl https://sh.rustup.rs -sSf | sh -s -- -y
}

install-uv() {
	curl -LsSf https://astral.sh/uv/install.sh | sh
}

install-volta() {
	curl https://get.volta.sh | bash
}

install-brew() {
	if [ -e "$BREW_PREFIX/bin/brew" ]; then
		echo "brew is already installed."
	else
		git clone https://github.com/Homebrew/brew "$BREW_PREFIX"
		eval "$(BREW_PREFIX/bin/brew shellenv)"
		brew update --force --quiet
	fi

	"$BREW_PREFIX/bin/brew" tap wez/wezterm-linuxbrew

}

install-nix() {
	if ! command -v nix &>/dev/null; then
		curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

		# shellcheck source=/dev/null
		source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
	else
		echo "Nix is already installed."
	fi

	if nix config show | grep 'use-xdg-base-directories = true' &>/dev/null; then
		echo "Nix is already configured to use XDG base directories."
	else
		echo "use-xdg-base-directories = true" | sudo tee -a /etc/nix/nix.conf
	fi
}

install-keyd() {
	if [ ! -e "/etc/keyd" ]; then
		sudo ln -s "$XDG_CONFIG_HOME/keyd" "/etc/keyd"
	fi

	if type "apt" &>/dev/null; then
		sudo add-apt-repository ppa:keyd-team/ppa
		sudo apt update
		sudo apt install keyd
	else
		echo "Unsupported OS."
		exit 1
	fi
}
