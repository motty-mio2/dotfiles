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
    $user_path = [System.Environment]::GetEnvironmentVariable('PATH', "User")

    if (-Not $user_path.Contains( $POETRY_DIR )) {
        [System.Environment]::SetEnvironmentVariable("PATH", $user_path + ";" + $POETRY_DIR, "User")
    }
}

function Set-Pyenv-Path {
    param (
        $PYENV_DIR = $env:USERPROFILE + "\.pyenv\pyenv-win"
    )

    foreach ($target in @( "PYENV", "PYENV_HOME", "PYENV_ROOT")) {
        $tmp_path = [System.Environment]::GetEnvironmentVariable("$target", "User")

        if (( $null -eq $tmp_path ) -or ($tmp_path -ne $PYENV_DIR )) {
            [System.Environment]::SetEnvironmentVariable('PYENV', $PYENV_DIR, "User")
        }
    }

    $user_path = [System.Environment]::GetEnvironmentVariable('PATH', "User")
    $pyenv_bin = $PYENV_DIR + "\bin"

    if (-Not $user_path.Contains( $pyenv_bin )) {
        [System.Environment]::SetEnvironmentVariable("PATH", $pyenv_bin + ";" + $user_path, "User")
    }

    $user_path = [System.Environment]::GetEnvironmentVariable('PATH', "User")
    $pyenv_shims = $PYENV_DIR + "\shims"

    if (-Not $user_path.Contains( $pyenv_shims )) {
        [System.Environment]::SetEnvironmentVariable("PATH", $pyenv_shims + ";" + $user_path, "User")
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

    Set-Environemt-Path -ENV_NAME "PATH" -ENV_VALUE "$RYE_HOME\shims"
    [System.Environment]::SetEnvironmentVariable("RYE_HOME", "$RYE_HOME", "User")
}

function Set-Rye-Path {
    param (
        $RYE_HOME = "$env:USERPROFILE\.local\share\rye"
    )
    Set-Environemt-Path -ENV_NAME "PATH" -ENV_VALUE "$RYE_HOME\shims"
    [System.Environment]::SetEnvironmentVariable("RYE_HOME", "$RYE_HOME", "User")

}

function Install-Rye-Tools {
    param (
        $RYE_ENV = "$env:USERPROFILE\.local\share\rye\shims",
        $executableName = "rye.exe"
    )

    foreach ($tool in @("poetry", "black", "flake8", "isort" , "mypy", "ruff", "hdl-checker")) {
        & "$RYE_ENV\$executableName" install $tool
    }
}

function Set-SVLINT-PATH {
    param (
        $SVLINT_CONFIG = $env:USERPROFILE + "\.config\svlint\svlint.toml"
    )

    Set-Environemt-Path -ENV_NAME "SVLINT_CONFIG" -ENV_VALUE $SVLINT_CONFIG
}
