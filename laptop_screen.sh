#!/usr/bin/env bash
sed -i -E s/Xft.dpi:163/Xft.dpi:116/ ~/dotfiles/.Xresources &&
    sed -i -E s/dpi=163/dpi=116/ ~/dotfiles/.xmobarrc &&
    xrdb ~/.Xresources &&
    xrandr --output DP1 --mode off --output eDP1 --auto --pos 0x0 --primary --rotate normal --rate 60 --dpi 116 &&
    xmonad --recompile && xmonad --restart &&
    killall chrome && google-chrome-stable &&
    ~/dotfiles/remap.sh
