#!/bin/bash

pids="$(pidof -x $(basename $0))"
kill "$(pgrep -x wofi)"
if [[ "$pids" != $$ ]]; then
    exit 1
fi

wofi --show drun --allow-images
