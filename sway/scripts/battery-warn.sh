#!/bin/bash

WARN_LEVEL=${1:-20}
ICON_PATH="$HOME/.config/sway/scripts/critical.png"

raw=""
level=""
status=""
id="NONE"

function warn() {
    if [ "$id" != "NONE" ]
    then
        notify-send              \
        -p                       \
        -u critical              \
        -t 3000                  \
        -i "$ICON_PATH"          \
        -r $id                   \
        "Battery Low"            \
        "Your Battery is at $1%" 
    else
        notify-send              \
        -p                       \
        -u critical              \
        -t 3000                  \
        -i "$ICON_PATH"          \
        "Battery Low"            \
        "Your Battery is at $1%"
    fi
}

while true; do
    raw="$(catnap -g battery)"
    level="$(echo $raw | cut -d ' ' -f1 | rev | cut -c2- | rev)"
    status="$(echo $raw | cut -d ' ' -f2)"

    if [ "$status" != "(Charging)" ] && [ "$level" -le "$WARN_LEVEL" ]
    then
        echo "Battery Low!"
        id=$(warn $level)
    else
        if [ "$id" != "NONE" ]
        then
            swaync-client --close-latest
            id="NONE"
        fi
    fi
    sleep 2
done