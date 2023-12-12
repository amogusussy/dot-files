export PATH=$PATH:~/.local/bin

if [[ $- != *i* ]]; then
  return # If not running interactively, don't do anything
fi

# Run startx when in tty
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  # export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
  # if ! test -d "${XDG_RUNTIME_DIR}"; then
  #   mkdir "${XDG_RUNTIME_DIR}"
  #   chmod 0700 "${XDG_RUNTIME_DIR}"
  # fi
  exec startx &
fi

# General aliases
PS1="$(date +%I:%M) \W $ "
alias ls='ls --color=auto --file-type'
alias q='exit'
alias ':q'='exit'
alias ':q!'='exit'
alias qq='exit'
alias python='python3'
alias grep='grep --color=auto -n'
alias fdd=fd
alias wc-l='wc -l'

# Vim aliases 
alias vim='nvim'
alias vi='nvim'
alias nvi='nvim'
alias vm='nvim'
alias vim='nvim'

# Kill Commands
alias ks='pkill steam && pkill steamwebhelper'
alias kq='pkill qbittorrent'
alias ke='pkill electron'
alias kf='pkill firefox'
alias kl='pkill librewolf'
alias kx='pkill Xorg'
alias kd='pkill discord && pkill socat'

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
alias la='ls'
alias ll='ls'
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
source /usr/share/bash-completion/completions/git

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

make_virt_env() {
  virtualenv -p python3 env
  source env/bin/activate
  pip3 install --upgrade pip
  if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
  fi
}

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
  doas xbps-install -Syu &&
  flatpak update -y
}

rmnvswap() {
  file="$(printf "$(pwd)/$1\n" | sed -e "s/\//%/g").swp"
  rm -f "$HOME/.local/state/nvim/swap/$file"
}

paste-file() {
  curl -F "file=@$1" https://0x0.st
}

backup() {
  excludes=$(printf " --exclude=\"%s\"" $(ls ~/.var/app/ -1 | /bin/grep -Pv "librewolf|qbittorrent"))

  echo $excludes | xargs rsync -av . /mnt/HoarderDrive/Backups/12-Dec-Back/ --exclude=.games/ --exclude=Torrents --exclude=.local/share/flatpak/ --exclude=.cache/ --exclude=~/.var/app/com.valvesoftware.Steam/.local/ --exclude=/home/matthew/.var/app/com.github.Eloston.UngoogledChromium/
}

chadwm() {
  cd ~/.config/chadwm/chadwm/
  nvim ./config.h +NvimTreeToggle
}

trash_rm () {
  local args=()
  for arg in "$@"; do
    if [[ $arg == -* ]]; then
      # this argument starts with a dash, so we assume it's an option and skip it
      continue
    fi
    args+=("$arg")
  done

  if [[ ${#args[@]} -eq 0 ]]; then
    echo "Error: No files or directories specified"
    return 1
  fi

  for arg in "${args[@]}"; do
    gio trash "$arg"
  done
}

mpv() {
  local replacements=("piped.kavin.rocks" "piped.projectsegfau.lt" "piped.in.projectsegfau.lt" "piped.video" "yewtu.be" "yt.revvy.de" "piped.yt")
  local args=("$@")
  local replaced_args=()

  for arg in "${args[@]}"; do
    local replaced_arg="$arg"
    for replacement in "${replacements[@]}"; do
      if [[ "$arg" == *"$replacement"* ]]; then
        replaced_arg="${replaced_arg//$replacement/youtube.com}"
      fi
    done
    replaced_args+=("$replaced_arg")
  done
  echo "${replaced_args[@]}"
  /bin/mpv "${replaced_args[@]}"
}

scrot() {
  /bin/scrot -F ~/Pictures/screenshots/$(date "+%s").png $@
}

startdbus() {
  doas mkdir -p /run/user/1000
  doas chown -R matthew /run/user/1000/
  sleep 2

  ~/.config/chadwm/scripts/pipewire-start &
}

printf "\e]0;haxxor terminal"
export EDITOR='nvim'

# History
# No HISTSIZE means no limit.
export HISTSIZE= 
export HISTFILESIZE=
export HISTTIMEFORMAT='%d/%m/%y %T '
export HISTCONTROL=ignoredups
export HISTIGNORE=' *:q:qq:clear:clea:shred:ckear:#:ks:kl:kq:m:history'

export XDG_RUNTIME_DIR=/run/user/$(id -u)
. "$HOME/.cargo/env"
