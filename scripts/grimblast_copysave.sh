#!/bin/sh

[[ $(pgrep -x slurp) ]] && exit 1
if ! grimblast copysave area; then
    grimblast copysave screen
fi
