#!/usr/bin/env bash
ALT_STYLE_DISABLED=$(rg '# corner-radius' ~/.config/picom/picom.conf)
if [[ -z "$ALT_STYLE_DISABLED" ]]; then # enabled, disable it
    sed -i -E 's/^(corner-radius|inactive-opacity|active-opacity) = /# \1 = /' ~/dotfiles/picom/picom.conf
else
    sed -i -E 's/# (corner-radius|inactive-opacity|active-opacity)/\1/' ~/dotfiles/picom/picom.conf
fi
