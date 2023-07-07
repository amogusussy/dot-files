export PATH=$PATH:~/.local/bin:~/.nimble/bin

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
alias fdd=fd

# Vim aliases alias vim='nvim'
alias vi='nvim'
alias nvi='nvim'
alias vm='nvim'
alias vim='nvim'

# Kill Commands
# alias ks='pkill steam'
ks() {
  read -p "Kill Steam? " yayornay
  if [ "$yayornay" == "y" ]; then
    pkill steam
  else
    ls
  fi;
}
alias kq='pkill qbittorrent'
alias ke='pkill electron'
alias kf='pkill firefox'
alias kl='pkill librewolf'
alias kx='pkill Xorg'

# Doas 
alias dias='doas'
alias dooas='doas'
alias doaas='doas'
alias doass='doas'

# Other
alias record='ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -c:v libx264 -preset veryfast $(date "+%s").mkv' 
alias l='ls'
alias s='ls'
alias lls='ls'
alias lsl='ls'
alias cls='ls'
alias sl='ls'
alias sls='ls'
alias ccd='cd'
alias d='cd'

# Clear
alias lear="clear"
alias cclear="clear"
alias lclear="clear"

# Auto Complete
complete -cf doas
complete -cf pkill
complete -cf which
complete -cf xbps-remove
complete -cf man
complete -cf time
complete -cf xargs
complete -cf cpulimit
complete -cf torsocks
complete -cf type
complete -d cd

reverse-output() {
  if [[ "$(pactl get-default-sink)" = "reverse-stereo" ]]; then
    printf "Audio already reversed\n"
    return
  fi
  pactl load-module module-remap-sink \
    sink_name=reverse-stereo \
    master=0 \
    channels=2 \
    master_channel_map=front-right,front-left \
    channel_map=front-left,front-right

  pactl set-default-sink reverse-stereo
}

# Run startx when in tty
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx &
    sleep 20 && reverse-output
fi

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

# override 'git clone' command
# git() {
#   local args=("$@")
#   local clone_cmd=("clone")
#
#   # find the 'clone' command and its position in the arguments
#   for (( i=0; i<${#args[@]}; i++ )); do
#     if [[ ${args[$i]} == "clone" ]]; then
#       clone_cmd+=("${args[$((i+1))]}")
#       break
#     fi
#   done
#
#   # check if the found 'clone' command is a github repository
#   if [[ ${clone_cmd[1]} == https://github.com* ]]; then
#     local url=${clone_cmd[1]}
#     url=${url/https:\/\/github.com/git@github.com:}
#     url=${url%.git}.git
#     clone_cmd[1]="$url"
#   fi
#
#   # replace the original 'clone' command with modified one
#   for (( i=0; i<${#args[@]}; i++ )); do
#     if [[ ${args[$i]} == "clone" ]]; then
#       args[$i]="${clone_cmd[@]}"
#       break
#     fi
#   done
#
#   printf "%s\n" "${clone_cmd[@]}"
#
#   /usr/bin/git ${args[@]}
# }

stream() {
  streamlink -p mpv $1 best
}

up() {
    cd $(printf "%.s../" $(seq "$1"));
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
  rsync -av . /mnt/SteamDrive/Backups/01-July-Back/ --exclude=Games/ --exclude=Torrents --exclude=.local/share/flatpak/ --exclude=.cache/ --exclude=".var/app/com.valvesoftware.Steam/.local/" --exclude="./.var/app/com.github.Eloston.UngoogledChromium/"
}

chadwm() {
  cd ~/.config/chadwm/chadwm/
  nvim ./config.h +NvimTreeToggle
}
#
# function rm () {
#   local args=()
#   for arg in "$@"; do
#     if [[ $arg == -* ]]; then
#       # this argument starts with a dash, so we assume it's an option and skip it
#       continue
#     fi
#     args+=("$arg")
#   done
#
#   if [[ ${#args[@]} -eq 0 ]]; then
#     echo "Error: No files or directories specified"
#     return 1
#   fi
#
#   for arg in "${args[@]}"; do
#     gio trash "$arg"
#   done
# }

scrot() {
  scrot -F ~/Pictures/screenshots/$(date "+%s") $@
}

printf "\e]0;haxxor terminal"
printf "\x1b[\x3"
export EDITOR='nvim'

# History
export HISTIGNORE=' *:q:qq:clear:clea:shred:ckear:#:ks:kl:kq:m:history'
export HISTSIZE=1000000
export HISTTIMEFORMAT='%d/%m/%y %T '
