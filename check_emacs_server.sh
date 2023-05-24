#!/usr/bin/env bash
ACTIVE=$(systemctl --user status emacs | rg Active | head -n 1 | awk '{print $2}')
STARTING=$(journalctl --user --since "1 minute ago" -xeu emacs.service | rg -c --include-zero Starting)
STARTED=$(journalctl --user --since "1 minute ago" -xeu emacs.service | rg -c --include-zero Started)
if [[ $ACTIVE == "inactive" ]]; then # not running
    echo -ne $"\uf057 "              # cross
elif [[ $ACTIVE == "failed" ]]; then # not running
    echo -ne $"\uf057 "              # cross
else
    if [[ "$STARTED" != "0" ]]; then     # recent "Started" in logs, so still starting
        echo -ne $"\uf110 "              # spin
    elif [[ "$STARTING" != "0" ]]; then  # recent "Started" in logs, so started
        echo -ne $"\ue632 "              # emacs icon
    elif [[ $ACTIVE == "active" ]]; then # no recent "Started" in logs, but service is up, so started
        echo -ne $"\ue632 "              # emacs icon
    fi
fi
