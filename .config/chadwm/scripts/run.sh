#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --no-fehbg --bg-fill '/home/matthew/Pictures/Wallpapers/mountain.jpg'
xset r rate 200 50 &
#picom &
xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --off --output DP-1 --off


~/.config/chadwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
