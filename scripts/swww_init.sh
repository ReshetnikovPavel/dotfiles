#!/bin/bash

swww-daemon &
sleep 0.1s
~/scripts/swww.sh "$(cat ~/.cache/latest_wallpaper)"
