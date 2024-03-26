setxkbmap \
    -model pc105 \
    -layout us \
    -variant altgr-intl \
    -option terminate:ctrl_alt_bksp \
    -option ctrl:nocaps \

xcape -e 'Control_L=Escape'
xmodmap -e "$(xmodmap -pke | grep  "keycode\s\+42" | sed -E 's/=((\s\S){4})\s\S+/=\1 dead_greek/')"

# Remap the Grave Accent/Backtick key to act as Backspace
xmodmap -e "keycode 49 = BackSpace"
# Remap BackSpace to backslash (\)
xmodmap -e "keycode 22 = backslash bar"
# Remap the Backspace key to act as the Grave Accent/Backtick key
xmodmap -e "keycode 51 = grave asciitilde"
