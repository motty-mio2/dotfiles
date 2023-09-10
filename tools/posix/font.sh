#!/bin/bash

array=()
WORKDIR="$HOME/tmp"
mapfile -t array < <(curl -s https://api.github.com/repos/yuru7/HackGen/releases/latest | grep browser_download_url | cut -d : -f 2,3 | tr -d \")

mkdir "$WORKDIR"
cd "$WORKDIR" || exit

for i in "${array[@]}"; do
	# echo -n "___"
	# echo -n "$i"
	# echo "___"
	url=$(echo "$i" | tr -d ' ')
	echo "$url"
	curl -sL -o ./tmp.zip "$url"
	# exit
	# echo "$i"
	# curl -OL  "$i"
	# curl -OL "$url"
	unzip -oq ./tmp.zip
	# exit
	rm ./tmp.zip

done
# mv ./* ~/.fonts

for a in ./*; do
	di=$(echo "$a" | cut -d / -f 2)
	echo "$di"
	cp -r "$WORKDIR/$di/*" "$HOME/.fonts/"
done

# rm -rf ~/tmp

# url=( '$(curl -s https://api.github.com/repos/yuru7/HackGen/releases/latest | grep browser_download_url | cut -d : -f 2,3 | tr -d \")' )
# for u in $url;do
#     echo "here"
#     echo "${u}"
# done

# url2=${url/
# / -O}
# curl -O "${url2}"

# https://github.com/yuru7/HackGen/releases/latest/download/Hackgen_NF_v2.8.0.zip
