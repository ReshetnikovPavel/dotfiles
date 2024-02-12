#!/bin/bash


path="$HOME/personal/notes/todo"
# notify-send --urgency=critical "$(cat $path)"

while true; do
    notify-send --urgency=critical "$(cat $path)"
    sleep 1h
done
