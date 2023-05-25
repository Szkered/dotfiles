#!/usr/bin/env bash
sudo pacman -S --needed - <pacman-list.pkg
xargs -d '\n' paru -S --needed <pacman-list-foreign.pkg
