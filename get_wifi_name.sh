#!/usr/bin/env bash
WIFI_NAME=$(iw wlan0 link | awk 'NR==2 {for (i=2; i<=NF; i++) printf $i " "; print ""}')
echo "   $WIFI_NAME"
