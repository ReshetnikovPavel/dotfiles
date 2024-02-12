#!/bin/sh

[[ $(pgrep -x slurp) ]] && exit 1
if ! grimblast copy area; then
    grimblast copy screen
fi
