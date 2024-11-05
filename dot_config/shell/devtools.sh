#!/usr/bin/env bash

# Install Package Manager

install-deno() {
	curl -fsSL https://deno.land/install.sh | sh
}

install-rust() {
	curl https://sh.rustup.rs -sSf | sh -s -- -y
}

install-rye() {
	curl -sSf https://rye.astral.sh/get | bash
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
		git clone https://github.com/Homebrew/brew $BREW_PREFIX
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

# Install Tools

install-uv-tools() {
	tools=("poetry" "black" "flake8" "ignr" "isort" "mypy" "ruff")

	for tool in "${tools[@]}"; do
		"$CARGO_HOME/bin/uv" uninstall "$tool"
		"$CARGO_HOME/bin/uv" install "$tool"
	done

	"$CARGO_HOME/bin/uv" uninstall "dixp"
	"$CARGO_HOME/bin/uv" install --from git+https://github.com/motty-mio2/dixp.git dixp
}

install-volta-tools() {
	"$VOLTA_HOME/bin/volta" install node@lts

	tools=("biome" "@bitwarden/cli" "neovim" "pyright" "bash-language-server" "tree-sitter-cli")
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
		oh-my-posh-bin pkg-config screen shellcheck-bin shfmt starship tree ttf-hackgen unarchiver unzip \
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
	"${BREW_PREFIX}/bin/brew" tap wez/wezterm-linuxbrew
	"${BREW_PREFIX}/bin/brew" install \
		bat chezmoi go-task \
		lazygit neovim \
		oh-my-posh sccache shellcheck shfmt starship stylua svls svlint \
		wezterm
}

install-nix-tools() {
	nix profile install "$(chezmoi source-path)/nix/cli/.#cli"
	nix profile install "$(chezmoi source-path)/nix/dev/.#dev"
}

install-arch-desktop-dependency() {
	yay -Sy fcitx5-im fcitx5-configtool fcitx5-mozc visual-studio-code-bin
}
