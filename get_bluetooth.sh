#!/bin/bash

regex="([0-9A-Z]*:)+"
DEVICES=$(bluetoothctl devices)
ICON=""
NAME=""
COLOR="#686868"
for DEVICE in $DEVICES; do
    if [[ $DEVICE =~ $regex ]]; then
        STATUS=$(bluetoothctl info $DEVICE | grep "Connected" | awk '{print $2}')
        if [ $STATUS = "yes" ]; then
            NAME=$(bluetoothctl info $DEVICE | grep "Name" | awk '{print $2}')
            ICON="  "
            COLOR="#bfbdb6"
        fi
    fi
done

echo "<fc=$COLOR><fn=1>$ICON</fn>$NAME</fc>"
