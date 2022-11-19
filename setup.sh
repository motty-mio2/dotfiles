#!/usr/bin/env bash

script_directory=$(cd "$(dirname "$0")" || exit; pwd)
conf_directory="$HOME/.config/shell"
mkdir -p "$conf_directory"

echo "$script_directory"
cd ~/ || return


mkdir ~/.fonts

setopt EXTENDED_GLOB

ln -s "${script_directory}/.p10k.zsh" "${HOME}/.p10k.zsh"
ln -s "${script_directory}/.nanorc" "${HOME}/.nanorc"
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

cargo install sheldon
mkdir -p "$HOME/.config/sheldon"
ln -s "$script_directory/conf/plugins.toml" "$HOME/.config/sheldon"
