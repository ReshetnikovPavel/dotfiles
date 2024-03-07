#!/bin/bash

kill "$(pgrep -x wofi)" || hyprctl dispatch killactive
