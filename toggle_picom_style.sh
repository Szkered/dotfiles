#!/usr/bin/env bash
ALT_STYLE_DISABLED=$(rg '# corner-radius' ~/.config/picom/picom.conf)
if [[ -z "$ALT_STYLE_DISABLED" ]]; then # enabled, disable it
    sed -i -E s'/^corner-radius = /# corner-radius = /' ~/dotfiles/picom/picom.conf
    sed -i -E s'/^inactive-opacity = /# inactive-opacity = /' ~/dotfiles/picom/picom.conf
    sed -i -E s'/^active-opacity = /# active-opacity = /' ~/dotfiles/picom/picom.conf
else
    sed -i -E s/'# corner-radius'/'corner-radius'/ ~/dotfiles/picom/picom.conf
    sed -i -E s/'# inactive-opacity'/'inactive-opacity'/ ~/dotfiles/picom/picom.conf
    sed -i -E s/'# active-opacity'/'active-opacity'/ ~/dotfiles/picom/picom.conf
fi
