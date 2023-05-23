#!/usr/bin/env bash
CURRENT_IM=$(fcitx5-remote -n)
echo -n "   "
if [[ $CURRENT_IM == "keyboard-us-altgr-intl" ]]; then
    echo -n "en"
elif [[ $CURRENT_IM == "pinyin" ]]; then
    echo -n "中"
fi
