# Python
Set-Alias python3 python
Set-Alias pip3 pip

function pchezmoi {
    chezmoi -S $Env:HOME/Projects/dotfiles
}

function wget  {
    wget --hsts-file="$Env:XDG_DATA_HOME/wget-hsts" $args
}

function ghf {
    gh repo clone $(gh repo list -L 10000 | fzf).Split("`t")[0]
}

function mygitconfig {
    git config --local user.name "motty"
    git config --local user.email "motty.mio2@gmail.com"
}
