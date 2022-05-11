Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
scoop reset

scoop install git 7zip sudo nano
scoop bucket add extras
scoop bucket add github-gh
scoop bucket add java
scoop bucket add viewer
scoop bucket add nonportable
scoop bucket add versions
scoop bucket add nerd-font
scoop bucket add hdl https://github.com/motty-mio2/scoop_hdl.git

scoop alias add upgrade 'scoop update && scoop update *' 'update all'
scoop alias add backup 'scoop export > ~\scoop.txt'
scoop alias add reinstall "scoop uninstall {0}; scoop install {0}"

git config --global credential.helper manager-core
git config --global core.autocrlf input
git config --global init.defaultBranch main
git config --global pull.rebase false

sudo sc config "Audiosrv" start= auto
