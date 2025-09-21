#!/bin/bash

sudo pacman -Syu --needed neovim yazi rustup git firefox chromium tor tmux ripgrep less ollama docker docker-compose jq brightnessctl swww fastfetch flatpak stow github-cli base-devel telegram-desktop yt-dlp uv uv npm playerctl wl-clipboard cliphist noto-fonts noto-fonts-cjk unzip hypridle xdg-user-dirs


if ! command -v yay >/dev/null 2>&1
then
	cd /tmp
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd -
fi

yay -Syu --needed nekoray-bin libinput-gestures walker elephant elephant-calc elephant-clipboard elephant-desktopapplications elephant-files elephant-todo ttf-apple-emoji quickshell 


flatpak install --or-update flathub com.discordapp.Discord com.obsproject.Studio


rustup update

nvim --headless "+Lazy! sync" +qa

if ! command -v hyprcwd >/dev/null 2>&1
then
	cargo install --git 'https://github.com/JonnieCache/hyprcwd-rs.git'
fi
