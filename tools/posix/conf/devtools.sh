#!/usr/bin/env bash

install-rye() {
	RYE_HOME="$HOME/.local/share/rye"
	export RYE_HOME="$HOME/.local/share/rye"

	curl -sSf https://rye-up.com/get | bash
}

install-rye-tools() {
	tools=("poetry" "black" "flake8" "isort" "mypy" "ruff" "pip" "--url git+https://github.com/motty-mio2/dixp dixp")

	for tool in "${tools[@]}"; do
		"$RYE_HOME/shims/rye" install "$tool"
	done
}

install-volta() {
	export VOLTA_HOME="$HOME/.local/share/volta"

	if type "pacman" >/dev/null 2>&1; then
		yay -Sy volta-bin
	elif [ ! -d "$VOLTA_HOME" ]; then
		curl https://get.volta.sh | bash

	fi
}

install-volta-tools() {
	export VOLTA_HOME="$HOME/.local/share/volta"

	if type "pacman" >/dev/null 2>&1; then
		/usr/sbin/volta install node@lts
	else
		"$VOLTA_HOME/bin/volta" install node@lts
	fi

	tools=("@bitwarden/cli" "neovim")
	for tool in "${tools[@]}"; do
		"$VOLTA_HOME/bin/npm" install -g "$tool"
	done
}

install-homebrew() {
	BREW_PREFIX="$HOME/.local/share/brew"
	export BREW_PREFIX="$HOME/.local/share/brew"

	mkdir -p "$BREW_PREFIX"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -s -- --prefix="$BREW_PREFIX"

	eval "$("$BREW_PREFIX/bin/brew" shellenv)"
}

install-homebrew-tools() {
	brew tap wez/wezterm-linuxbrew
	brew install bat chezmoi fd fzf gh neovim sheldon starship svls svlint tree wezterm
}

install-rust() {
	curl https://sh.rustup.rs -sSf | sh -s -- -y
}

install-cargo-tools() {
	"$HOME/.cargo/bin/cargo" install cargo-update sccache git-ignore-generator
}

install-arch-desktop-dependency() {
	yay -Sy fcitx5-im fcitx5-configtool fcitx5-mozc visual-studio-code-bin
}
