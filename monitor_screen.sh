#!/usr/bin/env bash
sed -i -E s/Xft.dpi:116/Xft.dpi:163/ ~/dotfiles/.Xresources &&
    sed -i -E 's/dpi = 116/dpi = 163/' ~/dotfiles/xmobar/xmobar.hs &&
    xrdb ~/dotfiles/.Xresources &&
    xrandr --output DP-1-1 --mode 3840x2160 --pos 0x0 --primary --rotate normal --rate 60 --dpi 163 --output eDP-1-1 --off &&
    xmonad --restart &&
    nitrogen --set-zoom-fill --random ~/Dropbox/Wallpapers --save &&
    killall google-chrome-stable && google-chrome-stable &&
    ~/dotfiles/remap.sh &&
    ~/dotfiles/reload_emacs.sh &
