export PATH=$PATH:~/.local/bin

if [[ $- != *i* ]]; then
  return
  # If not running interactively, don't do anything
fi

# General aliases
PS1="$(date +%I:%M) \W $ "
alias ls='ls --color=auto'
alias q='exit'
alias ':q'='exit'
alias ':q!'='exit'
alias qq='exit'
alias python='python3'

# Vim aliases alias vim='nvim'
alias vi='nvim'
alias nvi='nvim'
alias vm='nvim'
alias vim='nvim'

# Kill Commands
alias ks='pkill steam'
alias kq='pkill qbittorrent'
alias ke='pkill electron'
alias kf='pkill firefox'
alias kl='pkill librewolf'

# Other
alias record='ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -c:v libx264 -preset veryfast file.mkv' 
alias l='ls'
alias s='ls'
alias lls='ls'
alias lsl='ls'
alias cls='ls'
alias sl='ls'
alias ccd='cd'
alias d='cd'

# Auto Complete
complete -cf doas
complete -cf pkill
complete -cf which
complete -cf xbps-remove
complete -cf man
complete -cf time
complete -d cd

# Run startx when in tty
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx &
fi

reverse-output() {
  pactl load-module module-remap-sink sink_name=reverse-stereo master=0 channels=2 master_channel_map=front-right,front-left channel_map=front-left,front-right
  pactl set-default-sink reverse-stereo
}

stream() {
  streamlink -p mpv $1 best
}

up() {
    cd $(printf "%.s../" $(seq "$1"));
}

wget() {
  curl -L $1 -O
}

down() {
  curl -L $1 -o $2
}

clear() {
  printf '\E[H\E[J';
}

shutdown() {
  doas poweroff -h now
}

update() {
  doas flatpak update -y &&
  doas xbps-install -Syu
}

rmnvswap() {
  file="$(echo "$(pwd)/$1" | sed -e "s/\//%/g").swap"
  rm -f "$HOME/.local/state/nvim/swap/$file"
}

open() {
  cat $1 | less
}

echo -en "\e]0;haxxor terminal ${1}\a"
echo -en "\x1b[\x30 q" # Blinking block
export EDITOR='nvim'

# History
export HISTIGNORE=' *:q:qq:ls:clear:clea:'
export HISTSIZE=1000000
