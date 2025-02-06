#!/usr/bin/env bash

# Install Package Manager

install-deno() {
	curl -fsSL https://deno.land/install.sh | sh
}

install-rust() {
	curl https://sh.rustup.rs -sSf | sh -s -- -y
}

install-rust-tools() {
	rustup component add clippy rust-analysis rust-src rust-docs rustfmt rust-analyzer
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
		eval "$("$BREW_PREFIX"/bin/brew shellenv)"
		brew update --force --quiet
	fi
}

install-nix() {
	if ! command -v nix &>/dev/null; then
		curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

		# shellcheck source=/dev/null
		source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
	else
		echo "Nix is already installed."
	fi
}

install-keyd() {
	sudo ln -s "$HOME/.config/keyd" "/etc/keyd"

	keyd_version=$(curl -s https://api.github.com/repos/rvaiya/keyd/releases/latest | jq -r .tag_name)
	if ! command -v keyd &>/dev/null || [ "$(keyd --version | cut -d " " -f 2)" != "$keyd_version" ]; then
		DIR=$(mktemp -d)
		wget -P "$DIR" "https://github.com/rvaiya/keyd/archive/refs/tags/$keyd_version.zip"
		unzip "$DIR/$keyd_version.zip" -d "$DIR"
		cd "$DIR/keyd-${keyd_version:1}" || return
		make
		sudo make install
	fi
}
