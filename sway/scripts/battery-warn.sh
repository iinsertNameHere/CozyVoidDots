#!/bin/bash

LOW_BATTERY_THRESHOLD=${1:-20}
NOTIFICATION_ID=0

while true; do
    battery_info=$(catnap -g battery)
    charge=$(echo "$battery_info" | grep -oP '^\d+')
    status=$(echo "$battery_info" | grep -oP '(?<=\().*(?=\))')

    if [[ "$charge" -lt "$LOW_BATTERY_THRESHOLD" && "$status" == "Discharging" ]]; then
        message="Battery at ${charge}%. Please plug in your charger."

        # Send or update the notification using --replace-id
        NOTIFICATION_ID=$(notify-send -u critical -t 3000 --print-id --replace-id=$NOTIFICATION_ID "⚠️ Low Battery" "$message")
    else
        NOTIFICATION_ID=0  # Reset when not discharging or battery OK
    fi

    sleep 3
done