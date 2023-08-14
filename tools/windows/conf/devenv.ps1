# Python
Set-Alias python3 python
Set-Alias pip3 pip

# Volta
try {
    (& volta completions powershell) | Out-String | Invoke-Expression
}
catch {
}

# gh
try {
    (& gh completion -s powershell) | Out-String | Invoke-Expression
}
catch {
}

try {
    (& chezmoi completion powershell) | Out-String | Invoke-Expression
}
catch {
}

try {
    (& kubectl completion powershell) | Out-String | Invoke-Expression -ErrorAction SilentlyContinue
}
catch {
}

function ghf {
    gh repo clone $(gh repo list -L 10000 | fzf).Split("`t")[0]
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


function Set-Poetry-Path {
    param (
        $POETRY_DIR = $env:USERPROFILE + "\AppData\Roaming\Python\Scripts"
    )
    Set-Environemt-Path -ENV_NAME "PATH" -ENV_VALUE $POETRY_DIR

}

function Install-Rye {
    param (
        $url = "https://github.com/mitsuhiko/rye/releases/latest/download/rye-x86_64-windows.exe",
        $installDir = "$env:USERPROFILE\.local\bin",
        $RYE_HOME = "$env:USERPROFILE\.local\share\rye",
        $executableName = "rye.exe"
    )

    # Set Rye HOME
    if (-not (Test-Path -Path $RYE_HOME)) {
        New-Item -Path $RYE_HOME -ItemType Directory
    }

    [System.Environment]::SetEnvironmentVariable("RYE_HOME", "$RYE_HOME", "User")
    $env:RYE_HOME = "$RYE_HOME"

    # Install Rye
    if (-not (Test-Path -Path $installDir)) {
        New-Item -Path $installDir -ItemType Directory
    }

    Invoke-WebRequest -Uri $url -OutFile (Join-Path -Path $installDir -ChildPath $executableName)
    & "$installDir\$executableName"

    Remove-Item "$installDir\$executableName"

    Set-Environemt-Path -ENV_NAME "PATH" -ENV_VALUE "$RYE_HOME\shims"
    $env:PATH = "$RYE_HOME\shims;" + $env:PATH
}


function Install-Rye-Tools {
    param (
        $RYE_ENV = "$env:USERPROFILE\.local\share\rye\shims",
        $executableName = "rye.exe"
    )

    foreach ($tool in @("poetry", "black", "isort" , "mypy", "flake8", "ruff")) {
        & "$RYE_ENV\$executableName" install $tool
    }
}

function Set-SVLINT-PATH {
    param (
        $SVLINT_CONFIG = $env:USERPROFILE + "\.config\svlint\svlint.toml"
    )

    Set-Environemt-Path -ENV_NAME "SVLINT_CONFIG" -ENV_VALUE $SVLINT_CONFIG
}
function Set-Pyenv-Path {
    param (
        $PYENV_DIR = $env:USERPROFILE + "\.pyenv\pyenv-win"
    )

    Set-Environemt-Path -ENV_NAME "PYENV" -ENV_VALUE $PYENV_DIR
    Set-Environemt-Path -ENV_NAME "PYENV_HOME" -ENV_VALUE $PYENV_DIR
    Set-Environemt-Path -ENV_NAME "PYENV_ROOT" -ENV_VALUE $PYENV_DIR

    Set-Environemt-Path -ENV_NAME "PATH" -ENV_VALUE $PYENV_DIR + "\bin"
    Set-Environemt-Path -ENV_NAME "PATH" -ENV_VALUE $PYENV_DIR + "\shims"
}
