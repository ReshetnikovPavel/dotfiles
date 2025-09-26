#!/bin/bash

stow -R -v -t ~ rose-pine

kitty +kitten themes --reload-in=all Rosé Pine

hyprctl reload

cp nvim.lua "$HOME/.config/nvim/plugin/colorscheme.lua"

"$HOME/dotfiles/themes/rose-pine/Rose-Pine-GTK-Theme/themes/install.sh" --theme purple --color dark  --libadwaita

sudo flatpak override --filesystem=$HOME/.themes
flatpak override --user --filesystem=xdg-config/gtk-4.0
sudo flatpak override --env=GTK_THEME="Rosepine-Purple-Dark"

hyprctl setcursor rose-pine-hyprcursor 30

yes | nwg-look -a
