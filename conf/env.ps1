$env:DISPLAY = "localhost:0.0"
$env:PATH = $env:USERPROFILE + "\.poetry\bin" + ";" + "\scoop\apps\pyenv\current\pyenv-win\shims" + ";" + $env:PATH
$env:PYENV = $env:USERPROFILE + "\scoop\apps\pyenv\current\pyenv-win"
$env:PYENV_HOME = $env:USERPROFILE + "\scoop\apps\pyenv\current\pyenv-win"