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

# chezmoi
try {
    (& chezmoi completion powershell) | Out-String | Invoke-Expression
}
catch {
}

# kubectl
try {
    (& kubectl completion powershell) | Out-String | Invoke-Expression -ErrorAction SilentlyContinue
}
catch {
}

function ghf {
    gh repo clone $(gh repo list -L 10000 | fzf).Split("`t")[0]
}

function mygitconfig {
    git config --local user.name "motty"
    git config --local user.email "motty.mio2@gmail.com"
}
