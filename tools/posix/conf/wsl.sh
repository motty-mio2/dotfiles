#!/usr/bin/env bash
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

if grep -q microsoft /proc/version ; then
    agent_binary="$HOME/.local/bin/wsl2-ssh-agent"
    if [ ! -f "$agent_binary" ]; then
        curl -L https://github.com/mame/wsl2-ssh-agent/releases/latest/download/wsl2-ssh-agent --output "$agent_binary"
        chmod 755 "$agent_binary"
    fi

    eval "$("$agent_binary")"

    open() {
        if [ $# != 1 ]; then
            explorer.exe .
        else
            if [ -e "$1" ]; then
                cmd.exe /c start "$(wslpath -w "$1")" 2> /dev/null

            else
                if [ -e "$1" ]; then
                    cmd.exe /c start "$(wslpath -w "$1")" 2> /dev/null
                else
                    echo "open: $1 : No such file or directory"
                fi
            fi
        fi
    }
fi