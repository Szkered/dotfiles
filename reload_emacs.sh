#!/usr/bin/env bash
systemctl --user stop emacs &&
    doom sync &&
    rm ~/.config/emacs/.local/cache/save* &&
    systemctl --user start emacs &&
    emacsclient -r --eval "(emacs-startup-screen)"
