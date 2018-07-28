setxkbmap \
    -model pc105 \
    -layout us \
    -variant altgr-intl \
    -option \
    -option terminate:ctrl_alt_bksp \
    -option ctrl:nocaps \
    -option ctrl:swap_rwin_rctl \

xcape -e 'Control_L=Escape;Control_R=Super_R'
