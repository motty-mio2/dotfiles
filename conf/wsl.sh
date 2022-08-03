#!/bin/bash
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
#whome=$(wslpath "$(wslvar USERPROFILE)")

if [ -z "${SSH_AGENT_PID}" ]; then
    eval "$(ssh-agent)" 1>/dev/null
fi

export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
if ! ss -a | grep -q "$SSH_AUTH_SOCK" ; then
    rm -f "$SSH_AUTH_SOCK"
    ( setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"$HOME/whome/go/bin/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
fi

function open() {
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
