
function Set-Environemt-Value {
    param (
        $ENV_NAME,
        $ENV_VALUE
    )

    $current_setting = [System.Environment]::GetEnvironmentVariable($ENV_NAME, "User")

    # current_setting が設定されていないならば
    if ($current_setting -eq $null) {
        [System.Environment]::SetEnvironmentVariable("$ENV_NAME", "$ENV_VALUE", "User")
    }
    elseif ($current_setting -ne $ENV_VALUE) {
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

function Set-XDG-Directory {
    Set-Environemt-Value -ENV_NAME "XDG_CONFIG_HOME"    -ENV_VALUE "$env:USERPROFILE\.config"
    Set-Environemt-Value -ENV_NAME "XDG_DATA_HOME"      -ENV_VALUE "$env:USERPROFILE\.local\share"
    Set-Environemt-Value -ENV_NAME "XDG_CACHE_HOME"     -ENV_VALUE "$env:USERPROFILE\.local\cache"
    Set-Environemt-Value -ENV_NAME "XDG_STATE_HOME"     -ENV_VALUE "$env:USERPROFILE\.local\state"
    Set-Environemt-Value -ENV_NAME "HOME"               -ENV_VALUE "$env:USERPROFILE\.config"
}

function Set-Poetry-Path {
    param (
        $POETRY_DIR = $env:USERPROFILE + "\AppData\Roaming\Python\Scripts"
    )

    Set-Environemt-Path -ENV_NAME "PATH" -ENV_VALUE "$POETRY_DIR"
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

function Install-Rye {
    param (
        $url = "https://github.com/mitsuhiko/rye/releases/latest/download/rye-x86_64-windows.exe",
        $RYE_HOME = "$env:USERPROFILE\.local\share\rye",
        $executableName = "rye.exe"
    )

    # Set Rye HOME
    if (-not (Test-Path -Path $RYE_HOME)) {
        New-Item -Path $RYE_HOME -ItemType Directory
    }

    $env:RYE_HOME = "$RYE_HOME"

    # Install Rye
    Invoke-WebRequest -Uri $url -OutFile (Join-Path -Path $env:RYE_HOME -ChildPath $executableName)
    & "$env:RYE_HOME\$executableName"

    Remove-Item "$env:RYE_HOME\$executableName"

    $env:PATH = "$RYE_HOME\shims;" + $env:PATH

    Set-Rye-Path -RYE_HOME $RYE_HOME
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

    foreach ($tool in @("poetry", "black", "flake8", "isort" , "mypy", "ruff", "pip", "hdl-checker")) {
        & "$RYE_ENV\$executableName" install $tool
    }
}

function Install-Volta-Tools {
    param (
        $volta = "volta"
    )

    & "$volta" install node@lts
    foreach ($tool in @("@bitwarden/cli")) {
        & npm install -g $tool
    }
}

function Set-SVLINT-PATH {
    param (
        $SVLINT_CONFIG = $env:USERPROFILE + "\.config\svlint\svlint.toml"
    )

    Set-Environemt-Path -ENV_NAME "SVLINT_CONFIG" -ENV_VALUE $SVLINT_CONFIG
}
