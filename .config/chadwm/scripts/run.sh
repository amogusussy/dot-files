#!/bin/sh

# xrdb merge ~/.Xresources 
# xbacklight -set 10 &
feh --no-fehbg --bg-fill '/home/matthew/Pictures/Wallpapers/mountain.jpg'
xset r rate 200 50 &
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
#picom &


~/.config/chadwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
