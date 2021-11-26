# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
whome=$(wslpath $(wslvar USERPROFILE))

export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
ss -a | grep -q $SSH_AUTH_SOCK
if [ $? -ne 0   ]; then
    rm -f $SSH_AUTH_SOCK
    ( setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$whome/go/bin/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
fi