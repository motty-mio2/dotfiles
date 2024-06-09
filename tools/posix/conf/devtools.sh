#!/usr/bin/env bash

install-rye() {
	export RYE_HOME="$HOME/.local/share/rye"

	curl -sSf https://rye.astral.sh/get | bash
}

install-rye-tools() {
	tools=("poetry" "black" "flake8" "isort" "mypy" "ruff")

	for tool in "${tools[@]}"; do
		"$RYE_HOME/shims/rye" uninstall "$tool"
		"$RYE_HOME/shims/rye" install "$tool"
	done

	"$RYE_HOME/shims/rye" uninstall "dixp"
	"$RYE_HOME/shims/rye" install --url git+https://github.com/motty-mio2/dixp.git dixp
}

install-volta() {
	export VOLTA_HOME="$HOME/.local/share/volta"

	curl https://get.volta.sh | bash
}

install-volta-tools() {
	export VOLTA_HOME="$HOME/.local/share/volta"

	"$VOLTA_HOME/bin/volta" install node@lts

	tools=("@bitwarden/cli" "neovim" "pyright" "bash-language-server")
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
