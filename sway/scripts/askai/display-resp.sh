#!/bin/bash

swaymsg floating enable
# swaymsg resize set 1000 550

echo "AI is thinking...."

while [ ! -f "/tmp/askai-resp.md" ]; do
  sleep 0.2
done

clear
glow -w 80 /tmp/askai-resp.md

while true; do
    read -n 1 -s key  # -n 1 reads 1 character, -s makes it silent
    if [[ $key == "q" ]]; then
        echo "You pressed q, exiting..."
        break
    fi
done

exit