#!/usr/bin/env bash
ACTIVE=$(systemctl --user status emacs | rg Active | awk '{print $2}')
# check log to see if emacs is starting, compare the timestamp of the last Starting line
STARTING=$(journalctl --user -xeu emacs.service | rg Starting | tail -n 1 | awk -F' ' '{
    datetime_str = $1 " " $2 " " $3
    cmd = "date -d \"" datetime_str "\" +%s"
    cmd | getline datetime
    close(cmd)

    current_time = strftime("%s")

    if (current_time - datetime <= 120) {
        print "True"
    } else {
        print "False"
    }
}')
STARTED=$(journalctl --user -xeu emacs.service | rg Started)
if [[ $ACTIVE == "inactive" ]]; then # not running
    echo -ne $"\uf057 "
elif [[ $ACTIVE == "failed" ]]; then # not running
    echo -ne $"\uf057 "
else
    if [[ -z "$STARTED" ]]; then # started
        echo -ne $"\ue632 "
    elif [[ "$STARTING" == "True" ]]; then # starting
        echo -ne $"\uf110 "
    else # started
        echo -ne $"\ue632 "
    fi
fi
