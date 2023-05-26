#!/usr/bin/env bash
# desktop
sudo pacman -Syy --needed xorg lightdm xmonad xmonad-contrib xmobar dmenu picom nitrogen alacritty rofi rofi-emoji papirus-icon-theme intel-ucode ufw

# lightdm
sudo systemctl enable lightdm

# firewall
sudo ufw enable
sudo systemctl enable ufw.service

# paru
sudo pacman -Syy --needed base-devel

if ! command -v paru &>/dev/null; then
    echo "Installing paru..."
    git clone https://aur.archlinux.org/paru.git
    pushd paru
    makepkg -si
    popd
    rm -r paru
fi

paru -Syy --needed lightdm-mini-greeter google-chrome-stable

# media
sudo pacman -Syy --needed bluez blueman bluez-utils alsa-utils vlc playerctl

# PDF
paru -Syy --needed pandoc ghostscript

# tools & system
sudo pacman -Syy --needed cmake ntfs-3g rsync ripgrep jq xclip xdotool xorg-xprop xorg-xwininfo acpi zsh xcape maim feh libpng zlib poppler-glib htop nvtop aspell aspell-en npm cronie brightnessctl xautolock python

# latex
sudo pacman -Syy --needed texlive-most

# power management
paru -Syy --needed auto-cpufreq-git
sudo systemctl enable --now auto-cpufreq.service

# CUDA
sudo pacman -Syy --needed nvidia nvidia-settings nvidia-utils cudnn

# fonts
sudo pacman -Syy --needed ttc-iosevka ttc-iosevka-ss04 ttf-fira-code powerline-fonts

# emacs
paru -Syy --needed emacs-gtk3-native-comp-git-stable

# emacs server
systemctl --user enable emacs

# doom emacs
ln -s doom $HOME/.config/doom
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs
~/.config/emacs/bin/doom install

# zsh
chsh -s /usr/bin/zsh
curl -L git.io/antigen >$HOME/antigen.zsh                                                 # install antigen
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions # plugin
git clone git@github.com:wulfgarpro/history-sync.git $HOME/.zsh/history-sync              # plugin

# xmonad
mkdir "$HOME/.xmonad"
cp -r .xmonad "$HOME/.xmonad/"

# xprofile
cp .xprofile "$HOME/.xprofile"

# vpn
sudo pacman -Syy --needed trojan
paru -Syy --needed cisco-anyconnect

# dropbox
sudo pacman -Syy --needed python-gpgme
paru -Syy --needed dropbox
sudo cp dropbox.service /etc/systemd/system
sudo systemctl enable dropbox.service

# email
sudo pacman -Syy --needed openssl mu mbsync

# chinese
sudo pacman -Syy --needed fcitx5-im fcitx5-rime fcitx5-table-extra fcitx5-chinese-addons fcitx5-pinyin-zhwiki adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts noto-fonts

# install files
gpg2 --decrypt networks/trojan-config.json.gpg | sudo tee /etc/trojan/config.json

# Todos after installation:
# 1. change /etc/makepkg.conf to enable multi thread build
# 2. for laptop install xf86-video-intel
# 3. git clone git@github.com:Szkered/.zsh_history.git $HOME/.zsh_history_proj
# 4. git clone git@github.com:Szkered/pass-store.git $HOME/.password-store
# 5. link files
# 5. run install_pkgs.sh
