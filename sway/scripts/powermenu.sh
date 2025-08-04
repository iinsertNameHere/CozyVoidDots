#!/bin/bash

entries="󰍁\n\n⏻"

selected=$(echo -e $entries|rofi -config ~/.config/rofi/powermenu/config.rasi -dmenu)

echo $selected

case $selected in
  "󰍁")
    bash ~/.config/sway/scripts/lockscreen.sh;;
  "")
    loginctl reboot;;
  "⏻")
    loginctl poweroff -i;;
esac