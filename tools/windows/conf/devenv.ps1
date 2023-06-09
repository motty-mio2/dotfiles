# Python
Set-Alias python3 python
Set-Alias pip3 pip

# Volta
(& volta completions powershell) | Out-String | Invoke-Expression

# gh
(& gh completion -s powershell) | Out-String | Invoke-Expression

(& chezmoi completion powershell) | Out-String | Invoke-Expression

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
