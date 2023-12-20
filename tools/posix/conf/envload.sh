#!/usr/bin/env bash

if [ -d "${HOME}/.config/shell/" ]; then
	while read -r f; do
		# shellcheck source=/dev/null
		source "$f"
	done < <(find "${HOME}/.config/shell/" -type f -name "*.sh")
fi
