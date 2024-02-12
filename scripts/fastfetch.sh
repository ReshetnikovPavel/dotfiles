size=$(hyprctl activewindow -j | jq '.size')
width=$(echo $size | sed -r 's/\[ ([0-9]+).*/\1/')
# height=$(echo $size | sed -r 's/.*, ([0-9]+) \]/\1/')

width=$(echo "$width / 20" | bc)
max_width=40
width=$(( $width > $max_width ? $max_width : $width ))

fastfetch --sixel "$HOME/pictures/lucy_square.jpg" \
    --logo-width $width \
    --logo-padding 4 \
    "$@"
