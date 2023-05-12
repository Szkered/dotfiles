#!/usr/bin/env bash
HAS_SINK=$(pactl list sinks | awk '/Mute:/ { print $2 }')
if [[ $HAS_SINK == "yes" ]]; then # muted
    echo -ne $"\uf6a9  "
else # not muted
    echo -ne $"\uf028     "
fi
CAP_VOL=$(awk -F"[][]" '/Front Left:/ { print $2 }' <(amixer get Capture))
if [[ -n "$CAP_VOL" ]]; then
    echo -ne "$CAP_VOL  "
    exit
fi
MONO_VOL=$(awk -F"[][]" '/Mono:/ { print $2 }' <(amixer get Master))
if [ -z "$MONO_VOL" ]; then # is not mono
    awk -F"[][]" '/Front Left:/ { print $2 }' <(amixer get Master)
else # is mono
    echo -ne "$MONO_VOL"
fi
