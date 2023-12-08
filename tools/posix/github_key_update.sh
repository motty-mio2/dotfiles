#!/bin/bash

add_github_ssh_keys() {
    github_username="$1"

    github_keys_response=$(curl -s "https://github.com/$github_username.keys")
    authorized_keys_path=~/.ssh/authorized_keys

    while IFS= read -r line; do
        local ssh_key="$line"
        if ! grep -q "$ssh_key" "$authorized_keys_path"; then
            echo "$ssh_key" >> "$authorized_keys_path"
        fi
    done <<< "$github_keys_response"
}
