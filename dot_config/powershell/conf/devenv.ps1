# Python
Set-Alias python3 python
Set-Alias pip3 pip

function ghf {
    gh repo clone $(gh repo list -L 10000 | fzf).Split("`t")[0]
}

function mygitconfig {
    git config --local user.name "motty"
    git config --local user.email "motty.mio2@gmail.com"
}
