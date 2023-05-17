# svlint
$env:SVLINT_CONFIG = $env:USERPROFILE + "\.config\svls\.svlint.toml"
$SVLINT_CONFIG = $env:USERPROFILE + "\.config\svls\.svlint.toml"

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

function Set-Poetry-Path {
    param (
        $POETRY_DIR = $env:USERPROFILE + "\AppData\Roaming\Python\Scripts"
    )
    $user_path = [System.Environment]::GetEnvironmentVariable('PATH', "User")

    if (-Not $user_path.Contains( $POETRY_DIR )) {
        [System.Environment]::SetEnvironmentVariable("PATH", "$POETRY_DIR" + ";" + "$user_path", "User")
    }
}

function Set-Pyenv-Path {
    param (
        $PYENV_DIR = $env:USERPROFILE + "\.pyenv\pyenv-win"
    )

    foreach ($target in @( "PYENV", "PYENV_HOME", "PYENV_ROOT")) {
        $tmp_path = [System.Environment]::GetEnvironmentVariable("$target", "User")

        if ( ($null -eq $tmp_path) -Or ($tmp_path -ne $PYENV_DIR )) {
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
