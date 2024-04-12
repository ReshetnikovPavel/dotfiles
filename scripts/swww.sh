#!/bin/bash

# swww img --transition-type wipe --transition-angle 30 --transition-step 90 "$@" \

dimensions=$(identify -format "%wx%h" "$1[0]")
width=$(echo "$dimensions" | cut -d'x' -f1)
height=$(echo "$dimensions" | cut -d'x' -f2)
aspect_ratio=$(echo "scale=2; $width / $height" | bc)

options=""
if (( $(echo "$aspect_ratio < 1.3" | bc -l) )); then
    options+="--resize fit "
fi

swww img $options --transition-type fade "$1" \
    && echo "$1" > "$HOME/.cache/latest_wallpaper"
