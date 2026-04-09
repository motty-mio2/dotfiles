# motty's setup environments

## Installaion

### Linux / macOS

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply motty-mio2 -k
```

### Windows

In Devlopper Setting

- ローカルPowerShellスクリプトを許可する
- sudo 有効化する

```powershell
New-Item -ItemType Directory -Force $HOME/.local/bin
Invoke-WebRequest -Uri "https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi-windows-amd64.exe" -OutFile $HOME/.local/bin/chezmoi.exe
."$HOME/.local/bin/chezmoi.exe" init --apply -k motty-mio2
```

### Vim Only

```sh
mkdir -p "$HOME/.config/vim"
wget -P "$HOME/.config/vim" https://raw.githubusercontent.com/motty-mio2/dotfiles/refs/heads/main/dot_config/vim/vimrc
wget -P "$HOME/.config/vim" https://raw.githubusercontent.com/motty-mio2/dotfiles/refs/heads/main/dot_config/vim/option.vim
```

## Included Tools

### Common

- chezmoi
- neovim

## Package Manager

|                | Windows | Linux | macOS | system | desktop |
| -------------- | :-----: | :---: | :---: | :----: | :-----: |
| mise           |    o    |   o   |   o   |        |         |
| Homebrew       |    x    |  o→x  |   △   |   o    |    o    |
| apt / pacman   |    x    |   o   |   x   |   o    |    o    |
| snap / flatpak |    x    |   o   |   x   |   o    |    o    |
| AUR            |    x    |   o   |   x   |   o    |    o    |
| nix            |    x    |   o   |   o   |   o    |    o    |
| scoop          |    o    |   x   |   x   |        |    o    |
| winget         |    o    |   x   |   x   |   o    |    o    |

### macOS

Use nix as main package manager.
Use homebrew and mas-cli for some applications from nix-darwin.
