#!/usr/bin/env bash
WIFI_NAME=$(iw wlan0 link | awk 'NR==2 {for (i=2; i<=NF; i++) printf $i " "; print ""}')
COLOR="#686868"
if [ -z "$WIFI_NAME" ]; then
    ICON=""
else
    COLOR="#bfbdb6"
    ICON="   "
fi

echo "<fc=$COLOR><fn=1>$ICON</fn>$WIFI_NAME</fc>"
