#!/usr/bin/env bash
CUR_PLAYING=$(playerctl metadata --format '{{ artist }} - {{ title }}')
MAX_LEN=30
COUNT=$(echo -n "$CUR_PLAYING" | wc -c)
if [ -z "$CUR_PLAYING" ]; then
    echo ""
else
    if [ "$COUNT" -le "$MAX_LEN" ]; then
        echo $CUR_PLAYING
    else                                                 # Truncate and scroll
        OFFSET=$(date '+%s')                             # Get the current timestamp
        INDEX=$((OFFSET % (${#CUR_PLAYING} - $MAX_LEN))) # Calculate the starting index
        echo "${CUR_PLAYING:$INDEX:$MAX_LEN}"            # Truncate the string and display the segment
    fi
fi
