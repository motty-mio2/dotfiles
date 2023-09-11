#!/usr/bin/env bash
#export $SSH_AUTH_SOCK=""

if ! ls "$HOME"/.ssh/id* > /dev/null 2>&1 ; then
	if [ -n "$VSCODE_GIT_ASKPASS_NODE" ]; then
		alias code='${VSCODE_GIT_ASKPASS_NODE%/*}/bin/remote-cli/code'
	fi
fi
