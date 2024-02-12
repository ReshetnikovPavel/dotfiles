echo $(hyprcwd)
# title=$(hyprctl activewindow -j | jq '.title')
# path=$(echo $title | sed 's/.*://')
# path=${path/\~/${HOME}}
# path=${path%?}
# # notify-send "$(hyprctl activewindow)"
#
# if [ -d $path ]; then
#     echo $path
# else
#     echo $(hyprcwd)
# fi
