#!/usr/bin/zsh

script_directory=$(cd $(dirname $0); pwd)
repo_path=${script_directory%/*}
echo $script_directory
cd ~/

# Download Prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" > /dev/null

mkdir ~/.fonts
wget -P ~/.fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip > /dev/null
unar -D ~/.fonts/CascadiaCode.zip -o ~/.fonts
rm ~/.fonts/CascadiaCode.zip

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

echo "zstyle :prezto:module:prompt theme powerlevel10k" >> ~/.zpreztorc

ln -s "${script_directory}/.p10k.zsh" "${HOME}/.p10k.zsh"
ln -s "${script_directory}/.nanorc" "${HOME}/.nanorc"
ln -s "${script_directory}/conf/shell.sh" "${HOME}/conf/shell.sh"
echo "source ~/.profile" >> ~/.zshrc
echo "source ${script_directory}/conf/zsh.sh" >> ~/.zshrc
echo "source ${script_directory}/conf/bash.sh" >> ~/.bashrc
mkdir conf

# wsl setup
if [[ `cat /proc/version | grep 'microsoft'` ]]; then
    whome=$(wslpath $(wslvar USERPROFILE))
    sudo apt-get install -y golang socat
    go get -d github.com/jstarks/npiperelay
    GOOS=windows go build -o "${whome}/go/bin/npiperelay.exe" github.com/jstarks/npiperelay
    sudo apt-get purge -y golang
    sudo apt-get autoremove -y
    rm -rf ~/go
    ln -s $whome ~/whome
    ln -s "${script_directory}/conf/wsl.sh" "${HOME}/conf/wsl.sh"
    ln -s "${script_directory}/conf/server.sh" "${HOME}/conf/server.sh"
else
    echo "is this Server machine? [Y/n]"
    read ANS
    case $ANS in
    "" | [Yy]* )
        ln -s "${script_directory}/conf/server.sh" "${HOME}/conf/server.sh"
        ;;
    esac
fi

echo "Install linuxbrew? [Y/n]"
read ANS
case $ANS in
    "" | [Yy]* )
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ln -s "${script_directory}/conf/brew.sh" "${HOME}/conf/brew.sh"
    ;;
esac
