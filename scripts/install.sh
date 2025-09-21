#!/bin/bash

sudo pacman -Syu --needed neovim yazi rustup git firefox chromium tor tmux ripgrep less ollama docker jq brightnessctl swww fastfetch flatpak stow github-cli base-devel telegram-desktop yt-dlp uv uv npm playerctl


if ! command -v yay >/dev/null 2>&1
then
	cd /tmp
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd -
fi

yay -Syu --needed nekoray-bin libinput-gestures 


flatpak install --or-update flathub com.discordapp.Discord com.obsproject.Studio


rustup update
