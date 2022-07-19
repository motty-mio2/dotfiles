#!/bin/sh
#export $SSH_AUTH_SOCK=""

if [ -z "$VSCODE_GIT_ASKPASS_NODE" ]; then
   alias code="${VSCODE_GIT_ASKPASS_NODE%/*}/bin/remote-cli/code"
fi