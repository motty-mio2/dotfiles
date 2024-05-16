#!/usr/bin/env bash
#export $SSH_AUTH_SOCK=""

if [ -f "$HOME/.ssh/id*" ]; then
	eval "$(ssh-agent -s)"
else
	if [ -n "$VSCODE_GIT_ASKPASS_NODE" ]; then
		alias code='${VSCODE_GIT_ASKPASS_NODE%/*}/bin/remote-cli/code'
	fi
fi
