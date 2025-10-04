#!/bin/bash

set -o pipefail

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles"
config_path="$config_dir/screenshot.conf"
screenshots_dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/screenshots"
screenshot_path="$screenshots_dir/$(date +'%Y-%m-%d_%H:%M:%S.%3N').png" 

mkdir -p "$screenshots_dir" "$config_dir"

test -f "$config_path" && source "$config_path"
SLURP_BACKGROUND="${SLURP_BACKGROUND:-FFFFFF50}"
SLURP_BORDER="${SLURP_BORDER:-000000FF}"

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
grim -g "$(slurp -b $SLURP_BACKGROUND -c $SLURP_BORDER)"  - | tee "$screenshot_path" | wl-copy
kill $hyprpicker_pid
