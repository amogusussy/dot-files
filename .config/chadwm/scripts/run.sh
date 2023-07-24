#!/bin/sh
now=$(date "+%s")
feh --no-fehbg --bg-fill '/home/matthew/Pictures/Wallpapers/mountain.jpg'
xset r rate 200 50 &
export XDG_DATA_DIRS=$XDG_DATA_DIRS:~/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share
slstatus &
~/.config/chadwm/scripts/pipewire-start >> ~/.logs/pipewire/$now &
dbus-launch --sh-syntax --exit-with-session dwm
