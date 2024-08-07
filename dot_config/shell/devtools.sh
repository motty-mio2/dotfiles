#!/usr/bin/env bash

# Install Package Manager

install-rust() {
	curl https://sh.rustup.rs -sSf | sh -s -- -y
}

install-rye() {
	curl -sSf https://rye.astral.sh/get | bash
}

install-volta() {
	curl https://get.volta.sh | bash
}

install-brew() {
	if [ -e "$BREW_PREFIX/bin/brew" ]; then
		echo "brew is already installed."
	else
		mkdir -p "$BREW_PREFIX"
		curl -L https://github.com/brew/brew/tarball/master | tar xz --strip-components 1 -C "$BREW_PREFIX"
		eval "$("$BREW_PREFIX"/bin/brew shellenv)"
		brew update --force --quiet
	fi
}

install-nix() {
	if ! command -v nix-env &>/dev/null; then
		if grep -q microsoft /proc/version; then
			sh <(curl -L https://nixos.org/nix/install) --no-daemon
		else
			sh <(curl -L https://nixos.org/nix/install) --daemon
		fi

		# shellcheck source=/dev/null
		source "$HOME/.nix-profile/etc/profile.d/nix.sh"
	else
		echo "Nix is already installed."
	fi
}

# Install Tools

install-cargo-tools() {
	"$CARGO_HOME/bin/cargo" install cargo-update sccache git-ignore-generator
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

install-volta-tools() {
	"$VOLTA_HOME/bin/volta" install node@lts

	tools=("@bitwarden/cli" "neovim" "pyright" "bash-language-server" "tree-sitter-cli")
	for tool in "${tools[@]}"; do
		"$VOLTA_HOME/bin/volta" install "$tool"
	done
}

install-arch-tools() {
	sudo pacman -Sy --noconfirm --needed base-devel git
	if [ -e "/usr/bin/yay" ]; then
		echo "yay is already installed."
	else
		WORK_DIR=$(mktemp -d)
		git clone https://aur.archlinux.org/yay-bin.git "$WORK_DIR" --depth 1
		eval cd "$WORK_DIR" && makepkg --noconfirm -si
		rm -rf "$WORK_DIR"
	fi
	yay -Sy --noconfirm \
		bat byobu chezmoi curl fd fzf git github-cli go go-task-bin \
		htop jq nano neovim \
		oh-my-posh-bin pkg-config screen starship tree ttf-hackgen unarchiver unzip \
		wget zsh
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

install-brew-tools() {
	brew tap wez/wezterm-linuxbrew
	brew install \
		bat chezmoi go-task \
		lazygit neovim \
		oh-my-posh shellcheck shfmt starship stylua svls svlint \
		wezterm
}

install-nix-tools() {
	nix-env -i \
		arduino-language-server bat chezmoi go-task \
		lazygit neovim \
		oh-my-posh shellcheck shfmt starship stylua svls svlint \
		verible
}

install-arch-desktop-dependency() {
	yay -Sy fcitx5-im fcitx5-configtool fcitx5-mozc visual-studio-code-bin
}
