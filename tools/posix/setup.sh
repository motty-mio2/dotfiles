#!/usr/bin/bash

if type "apt" > /dev/null 2>&1; then
    echo "Ubuntu Mode"
    sudo sed -i.org -e 's|archive.ubuntu.com|ftp.jaist.ac.jp/pub/Linux|g' /etc/apt/sources.list
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt-get update
    sudo apt-get upgrade -qy
    sudo apt-get install -qy byobu curl git nano screen unar wget zsh libssl-dev build-essential golang
    
    elif type "pacman" > /dev/null 2>&1; then
    sudo pacman -Sy --noconfirm nano wget zsh git unarchiver byobu curl screen pkg-config
    
    elif type "dnf" > /dev/null 2>&1; then
    echo "RHEL Mode"
    sudo dnf -q -y groupinstall "Development Tools"
    sudo dnf -q -y install openssl-devel
else
    echo "None"
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

curl https://sh.rustup.rs -sSf | sh -s -- -y

~/.cargo/bin/cargo install cargo-update sccache sheldon
/home/linuxbrew/.linuxbrew/bin/brew install chezmoi
/home/linuxbrew/.linuxbrew/bin/chezmoi init motty-mio2
