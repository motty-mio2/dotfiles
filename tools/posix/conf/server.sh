#!/usr/bin/env bash
#export $SSH_AUTH_SOCK=""

id_files=( "$HOME"/.ssh/id* ) # ワイルドカード展開でファイルを取得

if [ ${#id_files[@]} -eq 0 ]; then
	if [ -n "$VSCODE_GIT_ASKPASS_NODE" ]; then
		alias code='${VSCODE_GIT_ASKPASS_NODE%/*}/bin/remote-cli/code'
	fi
fi
