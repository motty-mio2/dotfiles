#!/bin/sh

sudo pacman -S --noconfirm nano wget zsh git unarchiver

touch ~/.zshrc

zsh ./zsh.sh

./setup.sh
