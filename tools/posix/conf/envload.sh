
#!/usr/bin/env bash

dot_private="${HOME}/.config/shell/dotprivate/addon"
if [ -d "$dor_private" ]
then
    for file in "$dot_private"/*.sh ; do
        source "${file}"
    done
fi

private_folder="${HOME}/.config/shell/private"
if [ -d "$private_folder" ]
then
    for file in "$private_folder"/*.sh ; do
        source "${file}"
    done
fi