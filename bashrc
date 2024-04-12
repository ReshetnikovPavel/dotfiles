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
alias discord='discord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto'
alias neofetch="$HOME/scripts/fastfetch.sh"
alias fastfetch="$HOME/scripts/fastfetch.sh"
alias hypre='hyprctl dispatch exec'
alias he='hyprctl dispatch exec'
alias H='Hyprland'
alias powersave='cpufreqctl.auto-cpufreq --governor --set=powersave'
alias powerdaemonreset='cpufreqctl.auto-cpufreq --governor --set=reset'
alias powerinfo='sudo auto-cpufreq --debug'
alias hypredit="nvim $HOME/.config/hypr/hyprland.conf"
alias phind='tgpt --provider phind -m'
alias llama2='tgpt --provider llama2 -m'
alias fh='cat ~/.bash_history | fzf | wl-copy'
alias fb='cd "$(~/scripts/bookmarks.sh | fzf)"'
alias removeorphans='sudo pacman -Qdtq | sudo pacman -Rns -'
alias removedockershit='docker system prune -a -f'
alias spotdl='/home/pavelresh/personal/spotDL/venv/bin/spotdl'
alias yt-dlp-mp3='yt-dlp --extract-audio --audio-format mp3'
alias syncthingclient='hyprctl dispatch exec firefox http://127.0.0.1:8384'

function hr() {
    pkill "$1" && hyprctl dispatch exec "$1"
}

function zip_dir() {
    zip -r "${1%/}" "${1%/}"
}


# *Set default dirs*
export XDG_PICTURES_DIR=~/pictures
export XDG_SCREENSHOTS_DIR=~/pictures/screenshots

export LC_TIME='en_GB.UTF-8'

export TERM=foot
export TERMINAL=foot
export EDITOR=nvim
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_ENABLE_HIGHDPI_SCALING=1

# *Set fzf theme*
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:-1,hl:#ebbcba
	--color=fg+:#e0def4,bg+:-1,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

export BAT_THEME=rose-pine
