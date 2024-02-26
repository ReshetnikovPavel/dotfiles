#!/bin/bash

pids="$(pidof -x $(basename $0))"
kill "$(pgrep -x wofi)"
if [[ "$pids" != $$ ]]; then
    exit 1
fi

papers="$HOME/pictures/papers/"

ls $papers \
    | sed -r "s~(.*)~img:$papers\1:text:\1~" \
    | wofi --dmenu --allow-images -p 'Wallpapers' -c $HOME/.config/wofi/config-img \
    | sed -r "s~^img:.*:text:(.*)~$papers\1~" \
    | xargs ~/scripts/swww.sh 
