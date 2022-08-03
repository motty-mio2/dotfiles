$env:DISPLAY = "localhost:0.0"
$env:PATH = $env:USERPROFILE + "\AppData\Roaming\Python\Scripts" + ";" + $env:PATH
$env:PATH = $env:USERPROFILE + "\.pyenv\pyenv-win\bin" + ";" + $env:PATH
$env:PATH = $env:USERPROFILE + "\.pyenv\pyenv-win\shims" + ";" + $env:PATH

$env:PYENV = $env:USERPROFILE + "\.pyenv\pyenv-win\"
$env:PYENV_HOME = $env:USERPROFILE + "\.pyenv\pyenv-win\"
$env:PYENV_ROOT = $env:USERPROFILE + "\.pyenv\pyenv-win\"

$SVLINT_CONFIG = $env:USERPROFILE + "\.config\svls\.svlint.toml"
$env:SVLINT_CONFIG = $env:USERPROFILE + "\.config\svls\.svlint.toml"

# try {
#     $ENV:COMSPEC = (Get-Command pwsh -ErrorAction Stop).Definition
# }
# catch {
#     $ENV:COMSPEC = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.EXE"
# }
