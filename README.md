# mio2's setup environments for Linux Branch

## Installaion

### Linux

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply motty-mio2 -k
```

### Windows

```powershell
$tempFile = $(New-TemporaryFile).FullName + ".exe"; Invoke-WebRequest -Uri "https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi-windows-amd64.exe" -OutFile $tempFile; . $tempFile init --apply motty-mio2; Remove-Item $tempFile
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
