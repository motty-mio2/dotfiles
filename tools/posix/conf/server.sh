#!/usr/bin/env bash
#export $SSH_AUTH_SOCK=""

count=$(find "$HOME/.ssh" -name 'id*' 2>/dev/null | wc -l)

if [ "$count" -eq 0 ]; then
	if [ -n "$VSCODE_GIT_ASKPASS_NODE" ]; then
		alias code='${VSCODE_GIT_ASKPASS_NODE%/*}/bin/remote-cli/code'
	fi
fi
