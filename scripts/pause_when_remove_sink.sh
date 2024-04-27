#!/bin/bash


pactl subscribe | while read -r line; do
    if echo "$line" | grep "Event 'remove' on sink #[0-9]\+"; then
        playerctl -a pause
    fi
done
