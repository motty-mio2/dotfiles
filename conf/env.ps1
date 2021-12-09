$env:DISPLAY = "localhost:0.0"
<<<<<<< HEAD

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
=======
$env:PATH = $env:USERPROFILE + "\AppData\Roaming\Python\Scripts" + ";" + $env:PATH
$env:PATH = $env:USERPROFILE + "\.pyenv\pyenv-win\bin" + ";" + $env:PATH
$env:PATH = $env:USERPROFILE + "\.pyenv\pyenv-win\shims" + ";" + $env:PATH

$env:PYENV = $env:USERPROFILE + "\.pyenv\pyenv-win\"
$env:PYENV_HOME = $env:USERPROFILE + "\.pyenv\pyenv-win\"
$env:PYENV_ROOT = $env:USERPROFILE + "\.pyenv\pyenv-win\"
>>>>>>> 1fa8e9d69502348df7936a8073b386d98c85d29a
