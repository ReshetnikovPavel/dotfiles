#!/bin/bash

swww img --transition-type wipe --transition-angle 30 --transition-step 90 "$@" \
    && echo "$@" > "$HOME/.cache/latest_wallpaper"
