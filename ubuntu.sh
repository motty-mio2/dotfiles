sudo sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ub/linux/ubuntu/archive/%g" /etc/apt/sources.list
#sed -e "s/# set constantshow/set constantshow/" -e "s/# set linenumbers/set linenumbers/" -e "s/# set matchbrackets/set matchbrackets/" -e "s/# set mouse/set mouse/" -e "s/# set nonewlines/set nonewlines/" -e "s/# set tabsize 8/set tabsize 4/" -e "s/# set tabstospaces/set tabstospaces/" -e "s/# set trimblanks/set trimblanks/" -i ~/.nanorc
# sed -ie '$a set constantshow\nset linenumbers\nset historylog' /etc/nanorc && \
sudo apt-get update
sudo apt-get upgrade -qy
sudo apt-get install -qy curl nano wget screen zsh byobu git unar

touch ~/.zshrc
./setup.sh

zsh ./zsh.sh