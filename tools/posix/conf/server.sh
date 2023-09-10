#!/usr/bin/env bash
#export $SSH_AUTH_SOCK=""

if [ ! -e "$$HOME/.ssh/id*" ] && [ -n "$VSCODE_GIT_ASKPASS_NODE" ]; then
	alias code='${VSCODE_GIT_ASKPASS_NODE%/*}/bin/remote-cli/code'
fi
