#!/usr/bin/env bash

script_directory=$(cd "$(dirname "$0")" || exit; pwd)

sudo sed -i.org -e 's|archive.ubuntu.com|ftp.jaist.ac.jp/pub/Linux|g' /etc/apt/sources.list
#sed -e "s/# set constantshow/set constantshow/" -e "s/# set linenumbers/set linenumbers/" -e "s/# set matchbrackets/set matchbrackets/" -e "s/# set mouse/set mouse/" -e "s/# set nonewlines/set nonewlines/" -e "s/# set tabsize 8/set tabsize 4/" -e "s/# set tabstospaces/set tabstospaces/" -e "s/# set trimblanks/set trimblanks/" -i ~/.nanorc
# sed -ie '$a set constantshow\nset linenumbers\nset historylog' /etc/nanorc && \
sudo apt-get update
sudo apt-get upgrade -qy
sudo apt-get install -qy byobu curl git nano screen unar wget zsh

zsh "${script_directory}/setup.sh"
