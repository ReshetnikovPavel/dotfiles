#!/bin/bash

if ! alacritty -qq msg create-window --working-directory "$(hyprcwd)" "$@"; then
    alacritty -qq --working-directory "$(hyprcwd)" "$@"
fi
