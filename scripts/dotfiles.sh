#!/bin/bash


new_root_dir="$HOME/personal/dotfiles"
root_dir="$HOME"
paths=(
    'scripts'
    '.bashrc'
    '.config/bat'
    '.config/dunst'
    '.config/fastfetch'
    '.config/foot'
    '.config/hypr'
    '.config/nvim'
    '.config/qt5ct'
    '.config/waybar'
    '.config/wofi'
    '.config/yazi'
    '.config/zathura'
    '.config/libinput-gestures.conf'
    '.themes'
)

find "$new_root_dir" -mindepth  1 -maxdepth  1 | grep -v './.git.*' | xargs rm -r
for path in "${paths[@]}"; do
    new_path=$(echo "$new_root_dir/$path" | sed -r 's~/\.~/~g')
    echo $new_path
    mkdir -p $(dirname $new_path)
    if [[ -f "$root_dir/$path" ]]; then
        cp -p "$root_dir/$path" "$new_path"
    elif [[ -d "$root_dir/$path" ]]; then
        cp -p -R "$root_dir/$path" "$new_path"
    else
        echo "Something's wrong with the path"
    fi
done
