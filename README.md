# mio2's setup environments for Linux Branch

## Installaion

### Linux

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply motty-mio2
```

### Windows

```powershell
iwr https://raw.githubusercontent.com/motty-mio2/dotfiles/main/tools/windows/setup.ps1 | iex
```

## Included Tools

### Common

- chezmoi
- neovim
- git
- volta
- rye
- golang
- cargo/rust

### Linux

#### Package Manager

- AUR (Arch Destribution)
- brew / nixos (Other Destribution)

### Windows

- scoop
- winget
