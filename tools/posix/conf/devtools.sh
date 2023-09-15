#!/usr/bin/env bash

install-rye() {
	export RYE_HOME="$HOME/.local/share/rye"
	curl -sSf https://rye-up.com/get | bash

	tools=("poetry" "black" "flake8" "isort" "mypy" "ruff" "pip" "hdl-checker")

	for tool in "${tools[@]}"; do
		"$RYE_HOME/shims/rye" install "$tool"
	done
}

install-volta() {
	export VOLTA_HOME="$HOME/.local/share/volta"

	curl https://get.volta.sh | bash

	"$VOLTA_HOME/bin/volta" install node@lts

	tools=("poetry" "black" "flake8" "isort" "mypy" "ruff")

	for tool in "${tools[@]}"; do
		"$VOLTA_HOME/bin/npm" install -g "@bitwarden/cli"
	done
}

install-homebrew() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	/home/linuxbrew/.linuxbrew/bin/brew install bat chezmoi fd fzf gh neovim sheldon starship svls svlint tree
	/home/linuxbrew/.linuxbrew/bin/brew tap wez/wezterm-linuxbrew
	/home/linuxbrew/.linuxbrew/bin/brew install wezterm
}

install-rust(){
	curl https://sh.rustup.rs -sSf | sh -s -- -y

	~/.cargo/bin/cargo install cargo-update sccache git-ignore-generator
}