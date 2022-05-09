Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

iwr -useb get.scoop.sh | iex
scoop reset

scoop install git 7zip sudo nano
scoop bucket add extras
scoop bucket add github-gh
scoop bucket add java
scoop bucket add viewer
scoop bucket add nonportable
scoop bucket add versions
scoop bucket add nerd-font

scoop alias add upgrade 'scoop update && scoop update *' 'update all'
scoop alias add backup 'scoop export > ~\scoop.txt'
scoop alias add reinstall "scoop uninstall $*; scoop install $*"

git config --global credential.helper manager-core
git config --global core.autocrlf input
git config --global init.defaultBranch main
git config --global pull.rebase false

# (Get-Content ~\.nanorc) | % { $_ -replace "# set constantshow", "set constantshow" } | Set-Content ~\.nanorc

# sudo scoop install Cascadia-Code
sudo ~\scoop\apps\win32-openssh\current\install-sshd.ps1
sudo sc config "Audiosrv" start= auto
