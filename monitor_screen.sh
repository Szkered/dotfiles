#!/usr/bin/env bash
sed -i -E s/Xft.dpi:116/Xft.dpi:163/ ~/dotfiles/.Xresources &&
    sed -i -E s/dpi=116/dpi=163/ ~/dotfiles/.xmobarrc &&
    xrdb ~/.Xresources &&
    xrandr --output DP1 --mode auto --pos 0x0 --primary --rotate normal --rate 60 --dpi 163 --output eDP1 --off &&
    xmonad --recompile && xmonad --restart &&
    killall chrome && google-chrome-stable &&
    ~/dotfiles/remap.sh
