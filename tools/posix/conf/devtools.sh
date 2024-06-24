#!/usr/bin/env bash

install-rye() {
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
	curl https://get.volta.sh | bash
}

install-volta-tools() {
	"$VOLTA_HOME/bin/volta" install node@lts

	tools=("@bitwarden/cli" "neovim" "pyright" "bash-language-server" "tree-sitter-cli")
	for tool in "${tools[@]}"; do
		"$VOLTA_HOME/bin/volta" install "$tool"
	done
}

install-homebrew() {
	mkdir -p "$BREW_PREFIX"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -s -- --prefix="$BREW_PREFIX"

	eval "$("$BREW_PREFIX/bin/brew" shellenv)"
}

install-homebrew-tools() {
	brew tap wez/wezterm-linuxbrew
	brew install \
		bat chezmoi fd fzf gh \
		neovim \
		sheldon starship svls svlint tree \
		wezterm
}

install-rust() {
	curl https://sh.rustup.rs -sSf | sh -s -- -y
}

install-cargo-tools() {
	"$HOME/.cargo/bin/cargo" install cargo-update sccache git-ignore-generator
}

install-arch-tools() {
	sudo pacman -Sy --noconfirm --needed base-devel git go openssl tk xz zlib
	git clone https://aur.archlinux.org/yay.git
	cd yay || exit
	makepkg --noconfirm -si
	yay -Sy --noconfirm \
		bat byobu chezmoi curl fd fzf git github-cli go \
		htop jq nano neovim \
		oh-my-posh pkg-config screen sheldon starship tree ttf-hackgen unarchiver unzip \
		wget zsh
}

install-arch-desktop-dependency() {
	yay -Sy fcitx5-im fcitx5-configtool fcitx5-mozc visual-studio-code-bin
}

install-nix() {
	if grep -q microsoft /proc/version; then
		sh <(curl -L https://nixos.org/nix/install) --no-daemon
	else
		sh <(curl -L https://nixos.org/nix/install) --daemon
	fi

	# shellcheck source=/dev/null
	source "$HOME/.nix-profile/etc/profile.d/nix.sh"
}

install-nix-tools() {
	nix-env -i \
		arduino-language-server bat chezmoi fd go-task \
		lazygit neovim \
		oh-my-posh ripgrep sheldon shellcheck shfmt stylua starship svls svlint \
		verible
}

install-debian-tools() {
	sudo add-apt-repository ppa:longsleep/golang-backports
	sudo apt-get update
	sudo apt-get upgrade -qy
	sudo apt-get install -qy \
		bat build-essential byobu curl fd-find fzf git gh \
		htop jq libssl-dev nano \
		ripgrep tree unzip \
		wget zsh
}
