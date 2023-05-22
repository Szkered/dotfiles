#!/usr/bin/env bash
string=$(nvidia-smi --format=csv,noheader,nounits --query-gpu=temperature.gpu,memory.used,memory.total,utilization.gpu)
delimiter=","
counter=1

IFS="$delimiter" read -ra parts <<<"$string"

echo -n "gpu: "
for part in "${parts[@]}"; do
    case $counter in
        1) # temp
            echo -n "$part°C •"
            ;;
        2) # mem used
            echo -n "$part/"
            ;;
        3) # mem total
            echo -n "$part MiB •"
            ;;
        4) # mem total
            echo -n "$part%"
            ;;
    esac
    counter=$((counter + 1))
done
