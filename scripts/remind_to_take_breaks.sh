#!/bin/bash


while true; do
    sleep 30m
    if [[ "$(hyprcwd)" == "/home/pavelresh/college"* ]]; then
        message="It's $(date +%H:%M). You might want to take a break and rethink your strategy to solve this task. Don't bump your head into the wall for too long."
        notify-send -u critical "$message"
        # ~/scripts/say.sh "$message"
    fi
done
