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

# Rye Install
$url = "https://github.com/mitsuhiko/rye/releases/latest/download/rye-x86_64-windows.exe"
$RYE_HOME = "$env:USERPROFILE\.local\share\rye"
$executableName = "rye.exe"

if (-not (Test-Path -Path $RYE_HOME)) {
    New-Item -Path $RYE_HOME -ItemType Directory
}

$env:RYE_HOME = "$RYE_HOME"

## Get Installer
Invoke-WebRequest -Uri $url -OutFile (Join-Path -Path $env:HOME -ChildPath $executableName)
& "$env:HOME\$executableName"

Remove-Item "$env:HOME\$executableName"

$env:PATH = "$RYE_HOME\shims;" + $env:PATH
## Install Rye Tools
foreach ($tool in @("poetry", "black", "flake8", "isort" , "mypy", "ruff")) {
    & "$RYE_HOME\shimis\$executableName" install $tool
}

# Volta Install
volta install node@lts


sudo sc config "Audiosrv" start= auto

winget install Microsoft.OpenSSH.Beta --override ADDLOCAL=Client
