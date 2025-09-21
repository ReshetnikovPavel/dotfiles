#
# ~/.bashrc
#

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# *Enable vi mode*
set -o vi


# *Color my prompt*
BLACK="\[\e[30m\]"
RED="\[\e[31m\]"
BLUE="\[\e[32m\]"
YELLOW="\[\e[33m\]"
GREEN="\[\e[34m\]"
PURPLE="\[\e[35m\]"
PINK="\[\e[36m\]"
WHITE="\[\e[37m\]"
RESET="\[\e[m\]"

PS1="[${GREEN}\u${WHITE}@${PURPLE}\h ${BLUE}\W${WHITE}]\$ ${RESET}"


# *Set aliases*
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias q=exit
alias c=clear
alias n=nvim
alias he='hyprctl dispatch exec'
alias hypredit="nvim $HOME/.config/hypr/hyprland.conf"
alias removeorphans='sudo pacman -Qdtq | sudo pacman -Rns -'
alias removedockershit='docker system prune -a -f'
alias yt-dlp-mp3='yt-dlp --extract-audio --audio-format mp3'

function hr() {
    pkill "$1" && hyprctl dispatch exec "$1"
}

function zip-dir() {
    zip -r "${1%/}" "${1%/}"
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


export EDITOR=nvim

export PATH="$HOME/.cargo/bin:$PATH"
