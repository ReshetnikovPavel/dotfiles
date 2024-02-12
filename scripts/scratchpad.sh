if [ $(hyprctl activewindow -j | jq '.workspace.name') = '"special:scratchpad"' ]; then
    scratchpad -g
else
    scratchpad
fi

