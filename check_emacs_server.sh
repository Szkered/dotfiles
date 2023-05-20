#!/usr/bin/env bash
ACTIVE=$(systemctl --user status emacs | rg Active | awk '{print $2}')
STARTED=$(journalctl --user -xeu emacs.service | rg Started)
if [[ $ACTIVE == "inactive" ]]; then # not running
    echo -ne $"\uf057 "
elif [[ $ACTIVE == "failed" ]]; then # not running
    echo -ne $"\uf057 "
else
    if [[ -z "$STARTED" ]]; then # not started
        echo -ne $"\uf110 "
    else # started
        echo -ne $"\ue632 "
    fi
fi
