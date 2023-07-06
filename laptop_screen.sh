#!/usr/bin/env bash
sed -i -E s/Xft.dpi:163/Xft.dpi:116/ ~/dotfiles/.Xresources &&
    sed -i -E 's/dpi = 163/dpi = 116/' ~/dotfiles/xmobar/xmobar.hs &&
    xrdb ~/dotfiles/.Xresources &&
    xrandr --output DP-1-1 --off --output eDP-1-1 --auto --pos 0x0 --primary --rotate normal --rate 60 --dpi 116 &&
    xmonad --restart &&
    nitrogen --set-zoom-fill --random ~/Dropbox/Wallpapers --save &&
    killall google-chrome-stable && google-chrome-stable &&
    ~/dotfiles/remap.sh &&
    ~/dotfiles/reload_emacs.sh &
