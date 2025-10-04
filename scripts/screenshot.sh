#!/bin/bash

set -o pipefail

screenshots_dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/screenshots"
screenshot_path="$screenshots_dir/$(date +'%Y-%m-%d_%H:%M:%S.%3N').png" 

mkdir -p "$screenshots_dir"

pids="$(pidof -x $(basename $0))"
running_scripts_number=$(echo "$pids" | wc -w)

if (( $running_scripts_number > 1 )); then
	killall slurp
	sleep 0.1s
	grim "$screenshot_path"
	exit
fi

hyprpicker -r -z &
sleep 0.1s
hyprpicker_pid=$!

trap '[[ -s "$screenshot_path" ]] || rm -f "$screenshot_path"' EXIT
grim -g "$(slurp)"  - | tee "$screenshot_path" | wl-copy
kill $hyprpicker_pid
