#!/usr/bin/env bash
iw wlan0 link | awk 'NR==2 {for (i=2; i<=NF; i++) printf $i " "; print ""}'
