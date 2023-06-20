Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

powershell -NoProfile Install-Module -Name PSReadLine -Scope CurrentUser -Force
pwsh -NoProfile Install-Module -Name PSReadLine -Scope CurrentUser -Force

# Install Scoop
Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
scoop reset

scoop bucket add extras
scoop bucket add github-gh
scoop bucket add java
scoop bucket add viewer
scoop bucket add nonportable
scoop bucket add versions
scoop bucket add nerd-font
scoop bucket add hdl https://github.com/motty-mio2/mio2_bucket.git

scoop install 7zip bat bitwarden-cli chezmoi fd fzf gh git gsudonano less make neovim oh-my-posh posh-git psfzf rye svlint svls volta wezterm wget which

scoop alias add upgrade 'scoop update && scoop update *' 'update all'
scoop alias add backup 'scoop export > ~\scoop.txt'
scoop alias add reinstall "scoop uninstall {0}; scoop install {0}"

# Pyenv Install
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
~/.pyenv/pyenv-win/bin/pyenv-win install 3.10.9
~/.pyenv/pyenv-win/bin/pyenv-win global 3.10.9

# Poetry Install
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | ~/.pyenv/pyenv-win/shims/python -
~/AppData/Roaming/Python/Scripts/poetry.exe config virtualenvs.in-project true

# Volta Install
volta install node@lts


sudo sc config "Audiosrv" start= auto

winget install Microsoft.OpenSSH.Beta --override ADDLOCAL=Client
