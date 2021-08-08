chsh -s `which zsh`

rm ~/.zshrc
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

mkdir ~/.fonts
wget -P ~/.fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
unar -D ~/.fonts/CascadiaCode.zip -o ~/.fonts
rm ~/.fonts/CascadiaCode.zip

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

echo "zstyle :prezto:module:prompt theme powerlevel10k" >> ~/.zpreztorc

ln -sff ./.p10k.zsh ~/.p10k.zsh