#!/usr/bin/env bash
doom sync && systemctl --user restart emacs && emacsclient -r --eval "(emacs-startup-screen)"