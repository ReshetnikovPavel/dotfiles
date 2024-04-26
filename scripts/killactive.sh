#!/bin/bash


class=$(hyprctl -j activewindow | jq .class)

kill "$(pgrep -x wofi)" || hyprctl dispatch killactive

sleep 0.2
if [[ $class == *io.bassi.Amberol* ]]; then
    pkill -SIGUSR2 waybar
fi
