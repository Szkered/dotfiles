#!/usr/bin/env bash
ln -s alacritty.yaml $HOME/.config/alacritty/alacritty.yml
ln -s .antigenrc $HOME/.antigenrc
ln -s dunstrc $HOME/.config/dunst/dunstrc
ln -s isyncrc $HOME/.config/isyncrc
mkdir -p $HOME/.config/emacs/.local/etc/ispell
ln -s .pws $HOME/.config/emacs/.local/etc/ispell/.pws # local dictionary
ln -s .xmobarrc $HOME/.xmobarrc
ln -s .xprofile $HOME/.xprofile
ln -s .zshrc $HOME/.zshrc
