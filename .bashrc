export PATH=$PATH:~/.local/bin

if [[ $- != *i* ]]; then
  return
  # If not running interactively, don't do anything
fi

# General aliases
PS1="$(date +%I:%M) \W $ "
alias ls='ls --color=auto --file-type'
alias q='exit'
alias ':q'='exit'
alias ':q!'='exit'
alias qq='exit'
alias python='python3'
alias grep="grep --color=auto -n"

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
alias kx='pkill Xorg'

# Other
alias record='ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -c:v libx264 -preset veryfast file.mkv' 
alias l='ls'
alias s='ls'
alias lls='ls'
alias lsl='ls'
alias cls='ls'
alias sl='ls'
alias sls='ls'
alias ccd='cd'
alias d='cd'

# Auto Complete
complete -cf doas
complete -cf pkill
complete -cf which
complete -cf xbps-remove
complete -cf man
complete -cf time
complete -cf xargs
complete -cf cpulimit
complete -d cd

reverse-output() {
  if [[ "$(pactl get-default-sink)" = "reverse-stereo" ]]; then
    printf "Audio already reversed\n"
    return
  fi
  pactl load-module module-remap-sink sink_name=reverse-stereo master=0 channels=2 master_channel_map=front-right,front-left channel_map=front-left,front-right
  pactl set-default-sink reverse-stereo
}

# Run startx when in tty
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx &
    sleep 20 && reverse-output
fi

mpv() {
  /bin/mpv --volume=$(printf "$(playerctl volume) * 100 / 1\n"| bc) $@
}

shred() {
  for i in "$@"
  do
    if [[ -d $i ]];
    then
      if fd --base-directory "$i" -aqH0t f;
      then
        fd --base-directory "$i" -aH0t f | xargs -0 /bin/shred -zun 1;
      fi;
      if ! fd --base-directory "$i" -aqH0t f;
      then
        rm -rf "$i"
      fi;
    elif [[ -f "$i" ]]; 
    then
      /bin/shred "$@" -zun 1
    else
      printf "%s: No such file or directory\n" "$i"
    fi;
  done;
}

stream() {
  streamlink -p mpv $1 best
}

up() {
    cd $(printf "%.s../" $(seq "$1"));
}

# wget() {
#   curl -L $1 -O
# }

down() {
  curl -L $1 -o $2
}

clear() {
  printf '\E[H\E[J';
}

update() {
  doas flatpak update -y &&
  doas xbps-install -Syu
}

rmnvswap() {
  file="$(printf "$(pwd)/$1\n" | sed -e "s/\//%/g").swap"
  rm -f "$HOME/.local/state/nvim/swap/$file"
}

paste-file() {
  n="file=@$1"
  curl -F $n https://0x0.st
}

backup() {
  rsync -av . /mnt/SteamDrive/Backups/2-May-Back/ --exclude=Games/ --exclude=Torrents --exclude=.local/share/flatpak/ --exclude=.cache/ --exclude=".var/app/com.valvesoftware.Steam/.local/"
}

printf "\e]0;haxxor terminal"
printf "\x1b[\x30 q"
export EDITOR='nvim'

# History
export HISTIGNORE=' *:q:qq:clear:clea:shred:ckear:#:ks:kl:kq:m'
export HISTSIZE=1000000
