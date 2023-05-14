#!/usr/bin/env bash
sed -i -E s/Xft.dpi:116/Xft.dpi:163/ ~/dotfiles/.Xresources &&
    sed -i -E s/dpi=116/dpi=163/ ~/dotfiles/.xmobarrc &&
    xrdb ~/dotfiles/.Xresources &&
    xrandr --output DP1 --mode 3840x2160 --pos 0x0 --primary --rotate normal --rate 60 --dpi 163 --output eDP1 --off &&
    xmonad --restart &&
    killall chrome && google-chrome-stable &&
    ~/dotfiles/remap.sh
