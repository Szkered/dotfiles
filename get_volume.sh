#!/usr/bin/env bash
HAS_SINK=`pacmd list-sinks | awk '/muted/ { print $2 }'`
if [[ $HAS_SINK == "yes" ]]
then # muted
    echo -ne $"\uf6a9  "
else # not muted
    echo -ne $"\uf028     "
fi
awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master)
