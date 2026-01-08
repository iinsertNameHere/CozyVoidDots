#!/bin/bash

entries="󰍁\n\n⏻"

selected=$(echo -e $entries|rofi -config ~/.config/rofi/powermenu/config.rasi -dmenu)

echo $selected

case $selected in
  "󰍁")
    bash ~/.config/sway/scripts/lockscreen.sh;;
  "")
    rm ~/.cache/cliphist/db && loginctl reboot;;
  "⏻")
    rm ~/.cache/cliphist/db && loginctl poweroff -i;;
esac