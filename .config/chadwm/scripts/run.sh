#!/bin/sh
feh --no-fehbg --bg-fill '/home/matthew/Pictures/Wallpapers/mountain.jpg'
xset r rate 200 50 &
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
xrandr --output DP-5 --same-as HDMI-0 &
export XDG_DATA_DIRS=$XDG_DATA_DIRS:~/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share
slstatus &

exec dbus-launch --sh-syntax --exit-with-session dwm
