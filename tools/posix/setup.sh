#!/usr/bin/bash

if type "pacman" > /dev/null 2>&1; then
    sudo pacman -Sy --noconfirm yay rustup
    rustup install stable 
    yay -S  bat byobu chezmoi code curl fcitx-im fcitx-configtool fcitx-mozc fd fzf git github-cli go \
    nano neovim \
    oh-my-posh pkg-config rye screen sheldon starship tree ttf-hackgen unarchiver unzip \
    volta-bin wezterm wget yay zsh 

   cargo install cargo-update sccache git-ignore-generator

    # Use chezmoi
    chezmoi init motty-mio2
    chezmoi apply -k
    chezmoi apply -k

else
    if type "apt" > /dev/null 2>&1; then
        echo "Ubuntu Mode"
        #     sudo sed -i.org -e 's|archive.ubuntu.com|ftp.jaist.ac.jp/pub/Linux|g' /etc/apt/sources.list
        sudo add-apt-repository ppa:longsleep/golang-backports
        sudo apt-get update
        sudo apt-get upgrade -qy
        sudo apt-get install -qy byobu curl git nano screen unar wget zsh libssl-dev build-essential golang
        # Pyenv Dependency
        sudo apt-get install -y \
        build-essential curl llvm make tk-dev xz-utils wget \
        libbz2-dev libffi-dev liblzma-dev libncursesw5-dev libreadline-dev \
        libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev zlib1g-dev \
        python3-dev python3-venv python-is-python3
        
        elif type "dnf" > /dev/null 2>&1; then
        echo "RHEL Mode"
        sudo dnf -q -y groupinstall "Development Tools"
        # Pyenv dependency
        if [ -f "/etc/fedora-release" ]; then
            sudo dnf -q -y install make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-devel libnsl2-devel
        else
            sudo yum -q -y install gcc make patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel python39
        fi
        
        elif type "zypper" > /dev/null 2>&1; then
        zypper install gcc automake bzip2 libbz2-devel xz xz-devel openssl-devel ncurses-devel \
        readline-devel zlib-devel tk-devel libffi-devel sqlite3-devel libgdbm-devel make findutils
    else
        echo "None"
    fi

    # rye Install
    export RYE_HOME="$HOME/.local/share/rye"
    curl -sSf https://rye-up.com/get | bash

    tools=("poetry" "black" "flake8" "isort" "mypy" "ruff")

    for tool in "${tools[@]}"; do
        "$RYE_HOME/shims/rye" install "$tool"
    done

    # Volta Install
    curl https://get.volta.sh | bash
    ~/.volta/bin/volta install node@lts
    ~/.volta/bin/npm install -g @bitwarden/cli

    # Use Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    /home/linuxbrew/.linuxbrew/bin/brew install bat chezmoi fd fzf gh neovim sheldon starship svls svlint tree
    /home/linuxbrew/.linuxbrew/bin/brew tap wez/wezterm-linuxbrew
    /home/linuxbrew/.linuxbrew/bin/brew install wezterm

    # Use Rust
    curl https://sh.rustup.rs -sSf | sh -s -- -y

    ~/.cargo/bin/cargo install cargo-update sccache git-ignore-generator

    # Use chezmoi
    /home/linuxbrew/.linuxbrew/bin/chezmoi init motty-mio2
    /home/linuxbrew/.linuxbrew/bin/chezmoi apply -k
    /home/linuxbrew/.linuxbrew/bin/chezmoi apply -k
fi
