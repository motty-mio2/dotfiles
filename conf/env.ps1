$env:DISPLAY = "localhost:0.0"

$env:PATH = $env:USERPROFILE + "\.pyenv\pyenv-win\bin" + ";" + $env:PATH
$env:PATH = $env:USERPROFILE + "\.pyenv\pyenv-win\shims" + ";" + $env:PATH
$env:PATH = $env:USERPROFILE + "\.poetry\bin" + ";" + $env:PATH
$env:PATH = $env:USERPROFILE + "\go\bin" + ";" + $env:PATH

# PYENV
$env:PYENV = $env:USERPROFILE + "\.pyenv\pyenv-win\"
$env:PYENV_ROOT = $env:USERPROFILE + "\.pyenv\pyenv-win\"
$env:PYENV_HOME = $env:USERPROFILE + "\.pyenv\pyenv-win\"

# Poetry
poetry config virtualenvs.in-project true