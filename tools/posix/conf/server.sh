#!/usr/bin/env bash
#export $SSH_AUTH_SOCK=""

id_files=$(find "$HOME"/.ssh/id* 2>/dev/null | wc -l)

if [ "$id_files" ]; then
	eval "$(ssh-agent -s)" >/dev/null 2>&1
	ssh-add "$HOME"/.ssh/id* 2>/dev/null
else
	if [ -n "$VSCODE_GIT_ASKPASS_NODE" ]; then
		alias code='${VSCODE_GIT_ASKPASS_NODE%/*}/bin/remote-cli/code'
	fi
fi
