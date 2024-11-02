function Set-Environemt-Value {
    param (
        $ENV_NAME,
        $ENV_VALUE
    )

    $current_setting = [System.Environment]::GetEnvironmentVariable($ENV_NAME, "User")

    # current_setting が設定されていないならば
    if ($current_setting -eq $null) {
        [System.Environment]::SetEnvironmentVariable("$ENV_NAME", "$ENV_VALUE", "User")
    } elseif ($current_setting -ne $ENV_VALUE) {
        # current_setting が設定されている，かつ，設定されている値が $ENV_VALUE でないならば
        # print して，ユーザにどちらを利用するか確認する
        Write-Host "1) Current Setting: $current_setting"
        Write-Host "2) New Setting:     $ENV_VALUE"
        $answer = Read-Host "Which do you want to use? (1/2)"
        if ($answer -eq "2") {
            [System.Environment]::SetEnvironmentVariable("$ENV_NAME", "$ENV_VALUE", "User")
        }
    }
}

function Set-Environemt-Path {
    param (
        $ENV_NAME,
        $ENV_VALUE
    )

    $current_setting = [System.Environment]::GetEnvironmentVariable($ENV_NAME, "User")

    if (($null -eq $current_setting) -Or (-Not $current_setting.Contains( $ENV_VALUE ))) {
        [System.Environment]::SetEnvironmentVariable("$ENV_NAME", "$ENV_VALUE" + "; " + "$current_setting", "User")
    }
}

function Set-ESP-IDF-Path {
    param (
        $ESP_IDF_PATH = $env:USERPROFILE + "\.espressif"
    )

    Set-Environemt-Value -ENV_NAME "IDF_PATH" -ENV_VALUE "$env:USERPROFILE\esp\esp-idf"
    Set-Environemt-Value -ENV_NAME "IDF_TOOLS_PATH" -ENV_VALUE "$ESP_IDF_PATH"
}

function Set-XDG-Directory {
    Set-Environemt-Value -ENV_NAME "XDG_CONFIG_HOME"    -ENV_VALUE "$env:USERPROFILE\.config"
    Set-Environemt-Value -ENV_NAME "XDG_DATA_HOME"      -ENV_VALUE "$env:USERPROFILE\.local\share"
    Set-Environemt-Value -ENV_NAME "XDG_CACHE_HOME"     -ENV_VALUE "$env:USERPROFILE\.local\cache"
    Set-Environemt-Value -ENV_NAME "XDG_STATE_HOME"     -ENV_VALUE "$env:USERPROFILE\.local\state"
}

function Disable-Vispaly-Venv {
    Set-Environemt-Value -ENV_NAME "VIRTUAL_ENV_DISABLE_PROMPT" -ENV_VALUE "1"
}

function Set-Pyenv-Path {
    param (
        $PYENV_DIR = $env:USERPROFILE + "\.pyenv\pyenv-win"
    )

    foreach ($target in @( "PYENV", "PYENV_HOME", "PYENV_ROOT")) {
        Set-Environemt-Value -ENV_NAME $target -ENV_VALUE $PYENV_DIR
    }

    foreach ($target in @( "\bin", "\shims")) {
        Set-Environemt-Value -ENV_NAME $PYENV_DIR + $target -ENV_VALUE $PYENV_DIR
    }
}

function Install-Scoop {
    if ( -not (Get-Command "scoop")) {
        Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
    }

    scoop reset *

    # scoop alias add upgrade 'scoop update; scoop update *' 'update all'
    # scoop alias add backup 'scoop export > ~\scoop.txt'
    # scoop alias add reinstall "scoop uninstall {0}; scoop install {0}"

    scoop bucket add extras
    scoop bucket add java
    scoop bucket add versions
    scoop bucket add nerd-fonts
    scoop bucket add motty https://github.com/motty-mio2/scoop-bucket.git
}

function Install-Rye {
    param (
        $url = "https://github.com/astral-sh/rye/releases/latest/download/rye-x86_64-windows.exe",
        $RYE_HOME = "$env:USERPROFILE\.local\share\rye",
        $executableName = "rye.exe"
    )

    if (-Not(Get-Command rye -ea SilentlyContinue) ) {
        # Set Rye HOME
        if (-not (Test-Path "$RYE_HOME\$executableName")) {
            New-Item -Path $RYE_HOME -ItemType Directory -Force

            # Install Rye
            Invoke-WebRequest -Uri $url -OutFile (Join-Path -Path $RYE_HOME -ChildPath $executableName)
            & "$RYE_HOME\$executableName"

            Remove-Item "$RYE_HOME\$executableName"
        }

        Set-Rye-Path -RYE_HOME $RYE_HOME
    }
}

function Set-Rye-Path {
    param (
        $RYE_HOME = "$env:USERPROFILE\.local\share\rye"
    )
    Set-Environemt-Path -ENV_NAME "PATH" -ENV_VALUE "$RYE_HOME\shims"
    Set-Environemt-Value -ENV_NAME "RYE_HOME" -ENV_VALUE "$RYE_HOME"
}

function Install-Rye-Tools {
    param (
        $RYE_ENV = "$env:USERPROFILE\.local\share\rye\shims",
        $executableName = "rye.exe"
    )

    foreach ($tool in @("poetry", "black", "flake8", "ignr", "isort" , "mypy", "ruff")) {
        & "$RYE_ENV\$executableName" uninstall $tool
        & "$RYE_ENV\$executableName" install $tool
    }

    & "$RYE_ENV\$executableName" uninstall dixp
    & "$RYE_ENV\$executableName" install --url git+https://github.com/motty-mio2/dixp dixp
}

function Install-Volta-Tools {
    param (
        $VOLTA_HOME = "$Env:VOLTA_HOME"
    )

    & "$VOLTA_HOME\bin\volta" install node@lts

    foreach ($tool in @( "@bitwarden/cli", "neovim", "pyright", "bash-language-server", "tree-sitter-cli")) {
        & "$VOLTA_HOME\bin\volta" install $tool
    }
}

function Set-SVLINT-PATH {
    param (
        $SVLINT_CONFIG = $env:USERPROFILE + "\.config\svlint\svlint.toml"
    )

    Set-Environemt-Path -ENV_NAME "SVLINT_CONFIG" -ENV_VALUE $SVLINT_CONFIG
}

function Install-Scoop-Apps {
    scoop install `
        7zip bat chezmoi cloudflared curl fd fzf geekuninstaller gh git grep gsudo `
        less llvm make nano neovim `
        oh-my-posh posh-git psfzf psreadline ripgrep sccache shellcheck shfmt starship sysinternals `
        wezterm wget which
}
