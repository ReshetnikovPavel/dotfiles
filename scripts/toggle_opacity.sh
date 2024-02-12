#!/bin/bash


path=~/.config/alacritty/alacritty.yml
opacity=$(grep -oP 'opacity: \K\d+(\.\d+)?\s*' "$path")

if [ "$opacity" == "1" ]; then
    sed -i -r 's/(opacity: )([0-9]+(\.[0-9]+)?)/\10.5/' "$path"
else
    sed -i -r 's/(opacity: )([0-9]+(\.[0-9]+)?)/\11/' "$path"
fi
