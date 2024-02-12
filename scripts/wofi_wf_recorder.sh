#!/bin/bash

kill "$(pgrep -x wofi)"
rec_pid="$(pgrep -x wf-recorder)"
if kill -INT $rec_pid; then 
    pkill -RTMIN+8 waybar 
    while pgrep -x wf-recorder; do
        pkill -RTMIN+8 waybar 
        sleep 0.1s
    done
#    notify-send 'Recording is stopped'
    exit 1
fi

file="$HOME/videos/$(date +"%Y%m%d-%H%M%S")"

without_audio=' Without audio'
with_audio=' With audio'

function options() {
    echo $without_audio
    echo $with_audio
}

res=$(options | wofi --dmenu -p 'Record screen' --cache-file /dev/null)

pkill -RTMIN+8 waybar
if [[ $res == $without_audio ]]; then
    wf-recorder --file="$file.mkv"
elif [[ $res == $with_audio ]]; then
    wf-recorder --file="$file.mkv" --audio
else
    exit 1
fi
