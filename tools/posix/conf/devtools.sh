#!/usr/bin/env bash

ghf() {
	gh repo clone "$(gh repo list -L 10000 | fzf | awk '{print $1}')"
}

mygitconfig() {
	git config --local user.name "motty"
	git config --local user.email "motty.mio2@gmail.com"
}

# fonts
install-hackgen() {
	array=()
	WORKDIR="$HOME/tmp/hackgen"
	mapfile -t array < <(curl -s https://api.github.com/repos/yuru7/HackGen/releases/latest | grep browser_download_url | cut -d : -f 2,3 | tr -d \")

	mkdir -p "$HOME/.fonts"

	mkdir -p "$WORKDIR"
	cd "$WORKDIR" || exit

	for i in "${array[@]}"; do
		url=$(echo "$i" | tr -d ' ')
		echo "$url"
		curl -sL -o ./tmp.zip "$url"

		unzip -oq ./tmp.zip
		rm ./tmp.zip
	done

	for a in ./*; do
		di=$(echo "$a" | cut -d / -f 2)
		echo "$di"
		cp -r "$WORKDIR/$di/"* "$HOME/.fonts/"
	done

	rm -rf "$WORKDIR"
}

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

install-nix-tools() {
	nix-env -i \
		arduino-language-server bat chezmoi fd \
		lazygit neovim \
		oh-my-posh ripgrep sheldon shellcheck shfmt stylua starship svls svlint \
		verible
}
