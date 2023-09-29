#!/usr/bin/env bash

dot_private="${HOME}/.config/shell/dotprivate/addon"
if [ -d "$dot_private" ]; then
	for file in "$dot_private"/*.sh; do
		# shellcheck source=/dev/null
		source "${file}"
	done
fi

private_folder="${HOME}/.config/shell/private"
if [ -d "$private_folder" ]; then
	for file in "$private_folder"/*.sh; do
		# shellcheck source=/dev/null
		source "${file}"
	done
fi
