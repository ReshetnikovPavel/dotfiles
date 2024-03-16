#!/bin/bash

source ~/scripts/kill_other_wofi.sh

temp=$(mktemp -d)

function cleanup {      
  rm -rf "$temp"
}
trap cleanup EXIT

cliphist list \
    | grep -E '^[0-9]+\s\[\[ binary data .* ((png)|(jpg)|(jpeg)).* \]\]' \
    | while read line ; do
        id=$(echo $line | awk '{print $1;}')
        echo $line | sed 's/ /'$'\t''/' | cliphist decode > "${temp}/${id}"
    done

cliphist list \
    | sed -r "s~(^[0-9]+)\s(\[\[ binary data .* ((png)|(jpg)|(jpeg)).* \]\])~img:${temp}/\1:text:\1\t\2~" \
    | wofi --dmenu --allow-images -p 'Clipboard history' --cache-file /dev/null -c $HOME/.config/wofi/config-img \
    | sed -r "s~^img:${temp}/[0-9]+:text:(.*)~\1~" \
    | cliphist decode
