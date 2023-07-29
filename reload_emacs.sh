#!/usr/bin/env bash
systemctl --user restart emacs &&
    emacsclient -c --eval '(find-file "~/dotfiles/doom/config.org")'
