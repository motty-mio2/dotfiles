# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

alias ll='ls -la'
alias aupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias bupdate='brew update && brew upgrade'
alias pip='pip3'
alias python='python3'

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

source ~/conf/addon/*.sh > /dev/null

