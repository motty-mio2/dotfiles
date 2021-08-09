script_directory=$(cd $(dirname $0); pwd)
repo_path=${script_directory%/*}
echo $script_directory
cd ~/

# nano setup
ln -s "$script_directory/.nanorc" ~/.nanorc
ln -sr "$script_directory/conf" ~/conf

echo "source ~/.profile" >> ~/.zshrc


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

    echo "eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" >> ~/.zshrc
    echo "eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" >> ~/.bashrc
    ;;
esac
