#!/bin/bash

# swww img --transition-type wipe --transition-angle 30 --transition-step 90 "$@" \
swww img --transition-type fade "$@" \
    && echo "$@" > "$HOME/.cache/latest_wallpaper"
