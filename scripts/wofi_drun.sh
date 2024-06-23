#!/bin/bash

source ~/scripts/kill_other_wofi.sh

full_path=$(wofi --show drun --allow-images -p Applications -Ddrun-print_desktop_file=true)
filename=$(basename -- "$full_path")
filename_without_extension="${filename%.*}"

python ~/scripts/open_or_switch_to_app.py $filename_without_extension
