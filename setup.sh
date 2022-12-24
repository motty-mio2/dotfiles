#!/usr/bin/env bash

if type "apt" > /dev/null 2>&1; then
    echo "Ubuntu Mode"
    sudo sed -i.org -e 's|archive.ubuntu.com|ftp.jaist.ac.jp/pub/Linux|g' /etc/apt/sources.list
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt-get update
    sudo apt-get upgrade -qy
    sudo apt-get install -qy byobu curl git nano screen unar wget zsh libssl-dev build-essential golang
    elif type "pacman" > /dev/null 2>&1; then
    sudo pacman -Sy --noconfirm nano wget zsh git unarchiver byobu curl screen pkg-config
    elif [ -e /etc/fedora-release ]; then
    # Fedra
    echo "Fedora Mode"
else
    echo "None"
fi


script_directory=$(cd "$(dirname "$0")" || exit; pwd)
conf_directory="$HOME/.config/shell"
mkdir -p "$conf_directory"

echo "$script_directory"
cd ~/ || return


mkdir ~/.fonts

setopt EXTENDED_GLOB

ln -s "${script_directory}/conf/p10k.zsh" "${HOME}/.p10k.zsh"
ln -s "${script_directory}/conf/nanorc" "${HOME}/.nanorc"
ln -s "${script_directory}/conf/shell.sh" "${conf_directory}/shell.sh"


rm ~/.zshrc
rm ~/.bashrc
ln -s "${script_directory}/init/zshrc" ~/.zshrc
ln -s "${script_directory}/init/bashrc" ~/.bashrc

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ln -s "${script_directory}/conf/brew.sh" "${conf_directory}/brew.sh"

# wsl setup
if grep -q microsoft /proc/version ; then
    whome=$(wslpath "$(wslvar USERPROFILE)")
    sudo apt-get install -y golang socat
    go get -d github.com/jstarks/npiperelay
    GOOS=windows go build -o "${whome}/go/bin/npiperelay.exe" github.com/jstarks/npiperelay
    sudo apt-get purge -y golang
    sudo apt-get autoremove -y
    rm -rf ~/go
    ln -s "$whome" ~/whome
    ln -s "${script_directory}/conf/wsl.sh" "${conf_directory}/wsl.sh"
    ln -s "${script_directory}/conf/server.sh" "${conf_directory}/server.sh"
else
    echo "is this Server machine? [Y/n]"
    read -r ANS
    case $ANS in
        "" | [Yy]* )
            ln -s "${script_directory}/conf/server.sh" "${conf_directory}/server.sh"
        ;;
    esac
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

~/.cargo/bin/cargo install sheldon
mkdir -p "$HOME/.config/sheldon"
ln -s "$script_directory/conf/plugins.toml" "$HOME/.config/sheldon"

ssh-keygen -t ed25519
