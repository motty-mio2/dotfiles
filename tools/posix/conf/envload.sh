
#!/usr/bin/env bash

dot_private="${HOME}/.config/shell/dotprivate/addon"
for file in "$dot_private"/*.sh ; do
    source "${file}"
done

private_folder="${HOME}/.config/shell/private"
for file in "$private_folder"/*.sh ; do
    source "${file}"
done
