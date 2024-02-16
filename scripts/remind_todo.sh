#!/bin/bash


# path="$HOME/personal/notes/todo"
# notify-send --urgency=critical "$(cat $path)"

while true; do
    # notify-send --urgency=critical "$(cat $path)"
    notify-send --urgency=critical \
        "$(~/scripts/nextcloud/venv/bin/python3 ~/scripts/nextcloud/calendar_today.py)"
    sleep 1h
done
