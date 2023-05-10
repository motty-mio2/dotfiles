#!/usr/bin/env bash
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

eval '$("$HOME"/.local/bin/wsl2-ssh-agent)'

open() {
    if [ $# != 1 ]; then
        explorer.exe .
    else
        if [ -e "$1" ]; then
            cmd.exe /c start "$(wslpath -w "$1")" 2> /dev/null
        else
            echo "open: $1 : No such file or directory"
        fi
    fi
}
