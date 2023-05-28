#!/usr/bin/env bash
PKG_DIR=$HOME/dotfiles/pacman-sync
TMP_DIR=/tmp

pacman -Qen | awk '{print $1}' | sort | comm -23 - "$PKG_DIR/exclude.pkg" >"$TMP_DIR/my_native.pkg"
pacman -Qem | awk '{print $1}' | sort | comm -23 - "$PKG_DIR/exclude.pkg" >"$TMP_DIR/my_foreign.pkg"

sort -u "$PKG_DIR/native.pkg" | comm -23 - "$TMP_DIR/my_native.pkg" >"$TMP_DIR/native_toinstall.pkg"
sort -u "$PKG_DIR/foreign.pkg" | comm -23 - "$TMP_DIR/my_foreign.pkg" >"$TMP_DIR/foreign_toinstall.pkg"

sort -u "$PKG_DIR/native.pkg" | comm -13 - "$TMP_DIR/my_native.pkg" >"$TMP_DIR/native_toremove.pkg"
sort -u "$PKG_DIR/foreign.pkg" | comm -13 - "$TMP_DIR/my_foreign.pkg" >"$TMP_DIR/foreign_toremove.pkg"

sudo pacman -R - <"$TMP_DIR/native_toremove.pkg"
paru -R - <"$TMP_DIR/foreign_toremove.pkg"

sudo pacman -S --needed - <"$TMP_DIR/native_toinstall.pkg"
paru --skipreview -S --needed - <"$TMP_DIR/foreign_toinstall.pkg"
