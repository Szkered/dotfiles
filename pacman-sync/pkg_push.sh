#!/usr/bin/env bash
PKG_DIR=$HOME/dotfiles/pacman-sync
TMP_DIR=/tmp

pacman -Qen | awk '{print $1}' | sort | comm -23 - "$PKG_DIR/exclude.pkg" >"$PKG_DIR/native.pkg"
pacman -Qem | awk '{print $1}' | sort | comm -23 - "$PKG_DIR/exclude.pkg" >"$PKG_DIR/foreign.pkg"
