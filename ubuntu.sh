script_directory=$(cd $(dirname $0); pwd)
repo_path=${script_directory%/*}
echo $script_directory
cd ~/

sudo sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.iij.ad.jp/pub/linux/ubuntu/archive/%g" /etc/apt/sources.list
#sed -e "s/# set constantshow/set constantshow/" -e "s/# set linenumbers/set linenumbers/" -e "s/# set matchbrackets/set matchbrackets/" -e "s/# set mouse/set mouse/" -e "s/# set nonewlines/set nonewlines/" -e "s/# set tabsize 8/set tabsize 4/" -e "s/# set tabstospaces/set tabstospaces/" -e "s/# set trimblanks/set trimblanks/" -i ~/.nanorc
# sed -ie '$a set constantshow\nset linenumbers\nset historylog' /etc/nanorc && \
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y curl nano fonts-noto-cjk wget screen zsh byobu

# Zsh setup
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# nano setup
ln -s "${repo_path%/}/.nanorc" ~/.nanorc

echo "source ~/.profile" >> ~/.zshrc


ln -s "$script_directory/conf" ~/conf

echo "source ${HOME}/conf/zsh.sh" >> ~/.zshrc
echo "source ${HOME}/conf/bash.sh" >> ~/.bashrc

if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ];
then
        echo "source ${HOME}/conf/wsl.sh" >> ~/.zshrc
        echo "source ${HOME}/conf/wsl.sh" >> ~/.bashrc
fi

echo "is this Server machine? [Y/n]"
read ANS
case $ANS in
  "" | [Yy]* )
    echo "source ${HOME}/conf/server.sh" >> ~/.zshrc
    echo "source ${HOME}/conf/server.sh" >> ~/.bashrc
    ;;
esac

echo "Install linuxbrew? [Y/n]"
read ANS
case $ANS in
  "" | [Yy]* )
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ;;
esac
