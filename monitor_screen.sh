#!/usr/bin/env bash
sed -i -E s/Xft.dpi:116/Xft.dpi:163/ ~/dotfiles/.Xresources &&
    sed -i -E s/dpi\s=\s116/dpi\s=\s163/ ~/dotfiles/xmobar/xmobar.hs &&
    xrdb ~/dotfiles/.Xresources &&
    xrandr --output DP1 --mode 3840x2160 --pos 0x0 --primary --rotate normal --rate 60 --dpi 163 --output eDP1 --off &&
    xmonad --restart &&
    nitrogen --set-zoom-fill --random ~/Dropbox/Wallpapers --save &&
    killall min && prime-run min &&
    ~/dotfiles/remap.sh &&
    ~/dotfiles/reload_emacs.sh &
