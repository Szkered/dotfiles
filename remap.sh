setxkbmap \
    -model pc105 \
    -layout us \
    -variant altgr-intl \
    -option terminate:ctrl_alt_bksp \
    -option ctrl:nocaps \
    -option ctrl:swap_lwin_lctl \

xcape -e 'Control_L=Escape'
xmodmap -e "$(xmodmap -pke | grep  "keycode\s\+42" | sed -E 's/=((\s\S){4})\s\S+/=\1 dead_greek/')"
