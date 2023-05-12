#!/usr/bin/env bash
HAS_SINK=$(pactl list sinks | awk '/Mute:/ { print $2 }')
if [[ $HAS_SINK == "yes" ]]; then # muted
    echo -ne $"\uf6a9  "
else # not muted
    echo -ne $"\uf028     "
fi
awk -F"[][]" '/Mono:/ { print $2 }' <(amixer get Master)
