# XDG
$Env:XDG_CONFIG_HOME = "$Env:USERPROFILE\.config"
$Env:XDG_DATA_HOME = "$Env:USERPROFILE\.local\share"
$Env:XDG_CACHE_HOME = "$Env:USERPROFILE\.local\cache"
$Env:XDG_STATE_HOME = "$Env:USERPROFILE\.local\state"

# Use XDG
$Env:AWS_CONFIG_FILE = "$Env:XDG_CONFIG_HOME/aws/config"
$Env:CARGO_HOME = "$Env:XDG_DATA_HOME/cargo"
$Env:RUSTUP_HOME = "$Env:XDG_DATA_HOME/rustup"
$Env:CONDARC = "$Env:XDG_CONFIG_HOME/conda/condarc"
$Env:CUDA_CACHE_PATH = "$Env:XDG_CACHE_HOME/nv"
$Env:DOCKER_CONFIG = "$Env:XDG_CONFIG_HOME/docker"
$Env:DOTNET_CLI_HOME = "$Env:XDG_DATA_HOME/dotnet"
$Env:GTK_RC_FILES = "$Env:XDG_CONFIG_HOME/gtk-1.0/gtkrc"
$Env:GTK2_RC_FILES = "$Env:XDG_CONFIG_HOME/gtk-2.0/gtkrc"
$Env:GOPATH = "$Env:XDG_DATA_HOME/go"
$Env:LESSHISTFILE = "$Env:XDG_STATE_HOME/less/history"
$Env:NPM_CONFIG_USERCONFIG = "$Env:XDG_CONFIG_HOME/npm/npmrc"
$Env:PLATFORMIO_CORE_DIR = "$Env:XDG_DATA_HOME/platformio"
$Env:PYTHONSTARTUP = "$Env:XDG_CONFIG_HOME/python/pythonrc"
$Env:RYE_HOME = "$Env:XDG_DATA_HOME/rye"

# devenv
$Env:SVLINT_CONFIG = "$Env:HOME/.config/svls/.svlint.toml"
$Env:VOLTA_HOME = "$Env:USERPROFILE\scoop\apps\volta\current\appdata"
$Env:EDITOR = "nvim"
$Env:PIPENV_VENV_IN_PROJECT = "1"
$Env:DISPLAY = "localhost:0.0"

$Env:PATH = "$Env:USERPROFILE/.local/bin;$Env:PATH"


