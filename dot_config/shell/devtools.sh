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
	tools=("black" "flake8" "ignr" "isort" "mypy" "ruff")

	for tool in "${tools[@]}"; do
		"$HOME/.local/bin/uv" tool install --upgrade "$tool"
	done

	"$HOME/.local/bin/uv" tool install --upgrade --from git+https://github.com/motty-mio2/dixp.git dixp
}

install-volta-tools() {
	"$VOLTA_HOME/bin/volta" install node@lts

	tools=("@bitwarden/cli" "bash-language-server" "biome" "markdownlint-cli" "neovim" "pyright" "tree-sitter-cli")
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
		bat byobu chezmoi curl fd fzf git github-cli glab go go-task-bin \
		htop jq nano neovim \
		oh-my-posh-bin pkg-config screen shellcheck-bin shfmt starship stylua tree ttf-hackgen unarchiver unzip \
		wget zsh
}

install-debian-tools() {
	sudo apt-get update
	sudo apt-get upgrade -qy
	sudo apt-get install -qy \
		bat build-essential byobu curl fd-find fzf git \
		htop jq libssl-dev nano \
		ripgrep tree unzip \
		wget zsh
}

install-ubuntu-dev-tools() {
	sudo add-apt-repository ppa:longsleep/golang-backports
	sudo apt-get install ca-certificates curl

	echo "VSCode"
	curl https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/microsoft.gpg
	echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

	echo "Docker"
	if [ ! -f "/etc/apt/keyrings/docker.asc" ]; then
		sudo apt purge -y docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc
		sudo install -m 0755 -d /etc/apt/keyrings
		sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
		sudo chmod a+r /etc/apt/keyrings/docker.asc
	fi

	# Add the repository to Apt sources:
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(cat /etc/os-release && echo "$VERSION_CODENAME") stable" |
		sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

	echo "Wezterm"
	curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

	sudo apt-get update
	sudo apt-get install golang
	sudo apt-get install code
	sudo apt-get install flatpak
	sudo apt-get install wezterm
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	sudo apt-get install clangd clang-format clang-tidy
}

install-brew-tools() {
	"${BREW_PREFIX}/bin/brew" tap wez/wezterm-linuxbrew
	"${BREW_PREFIX}/bin/brew" install \
		bat chezmoi gh glab go-task \
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
