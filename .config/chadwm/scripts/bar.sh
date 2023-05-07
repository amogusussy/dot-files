#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/chadwm/scripts/bar_themes/tokyonight

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$black^ ^b$green^ CPU"
  printf "^c$white^ ^b$grey^ $cpu_val"
}

# pkg_updates() {
#   updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
#
#   if [ -z "$updates" ]; then
#     printf "  ^c$green^     Fully Updated"
#   else
#     printf "  ^c$green^     $updates"" updates"
#   fi
# }

mem() {
  printf "^c#7aa2f7^^b#1a1b26^  ^c#7aa2f7^ %s" $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
}

clock() {
  printf "^c#1a1b26^ ^b#7aa2f7^ 󱑆 ^c#1a1b26^^b#7aa2f7^ $(date '+%H:%M') "
}

while true; do

  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] # && updates=$(pkg_updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$(cpu) $(mem) $(clock)"
done
