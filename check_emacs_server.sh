#!/usr/bin/env bash
ACTIVE=$(systemctl --user status emacs | rg Active | awk '{print $2}')
STARTED=$(systemctl --user status emacs | rg "Started Emacs")
if [[ $ACTIVE == "inactive" ]]; then # not running
    echo -ne $"emacs: \uf057 "
elif [[ $ACTIVE == "failed" ]]; then # not running
    echo -ne $"emacs: \uf057 "
else                           # running
    if [ -z "$STARTED" ]; then # not started yet
        echo -ne $"emacs: \uf110 "
    else # started
        echo -ne $"emacs: \uf058 "
    fi
fi
