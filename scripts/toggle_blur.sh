#!/bin/bash


is_blur_enabled="$(hyprctl getoption decoration:blur:enabled | grep int: | tr -dc '0-9')"

if [[ $is_blur_enabled -eq 0 ]]; then
    hyprctl keyword decoration:blur:enabled true
else
    hyprctl keyword decoration:blur:enabled false
fi
