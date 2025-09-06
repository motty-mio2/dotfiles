# mio2's setup environments for Linux Branch

## Installaion

### Linux

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

## Included Tools

### Common

- chezmoi
- neovim
- git
- volta
- uv
- golang
- cargo/rust

### Linux

#### Package Manager

- AUR (Arch Destribution)
- brew / nixos (Other Destribution)

### Windows

- scoop
- winget
