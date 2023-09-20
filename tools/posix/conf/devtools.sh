#!/usr/bin/env bash

install-rye() {
	RYE_HOME="$HOME/.local/share/rye"
	export RYE_HOME="$HOME/.local/share/rye"

	if [ ! -d "$RYE_HOME" ]; then
		curl -sSf https://rye-up.com/get | bash
	fi
}

install-rye-tools() {
	tools=("poetry" "black" "flake8" "isort" "mypy" "ruff" "pip" "hdl-checker")

	for tool in "${tools[@]}"; do
		"$RYE_HOME/shims/rye" install "$tool"
	done
}

install-volta() {
	export VOLTA_HOME="$HOME/.local/share/volta"

	if [ ! -d "$VOLTA_HOME" ]; then
		curl https://get.volta.sh | bash

	fi
}

install-volta-tools() {
	export VOLTA_HOME="$HOME/.local/share/volta"

	"$VOLTA_HOME/bin/volta" install node@lts

	tools=("@bitwarden/cli" "neovim")
	for tool in "${tools[@]}"; do
		"$VOLTA_HOME/bin/npm" install -g "$tool"
	done
}

install-homebrew() {
	if [ ! -d "/home/linuxbrew/" ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
}

install-homebrew-tools() {
	/home/linuxbrew/.linuxbrew/bin/brew tap wez/wezterm-linuxbrew
	/home/linuxbrew/.linuxbrew/bin/brew install bat chezmoi fd fzf gh neovim sheldon starship svls svlint tree wezterm
}

install-rust() {
	if [ ! -d "$HOME/.cargo/bin" ]; then
		curl https://sh.rustup.rs -sSf | sh -s -- -y
	fi
}

install-cargo-tools(){
	"$HOME/.cargo/bin/cargo" install cargo-update sccache git-ignore-generator
}

install-arch-desktop-dependency(){
	yay -Sy fcitx5-im fcitx5-configtool fcitx5-mozc visual-studio-code-bin
}