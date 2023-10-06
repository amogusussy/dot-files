#!/bin/sh

export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
if ! test -d "${XDG_RUNTIME_DIR}"; then 
  mkdir "${XDG_RUNTIME_DIR}"
  chmod 0700 "${XDG_RUNTIME_DIR}" 
fi 
feh --no-fehbg --bg-fill '/home/matthew/Pictures/Wallpapers/kurz.png'
xset r rate 200 50 &
export XDG_DATA_DIRS=$XDG_DATA_DIRS:~/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share
slstatus &
~/.config/chadwm/scripts/pipewire-start &
dbus-launch --sh-syntax --exit-with-session dwm
