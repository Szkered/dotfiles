#!/usr/bin/env bash
# desktop
sudo pacman -S --noconfirm --needed xorg lightdm xmonad xmonad-contrib xmobar dmenu picom nitrogen alacritty rofi rofi-emoji papirus-icon-theme intel-ucode ufw xscreensaver xfce4-power-manager

# lightdm
sudo systemctl enable lightdm

# firewall
sudo ufw enable
sudo systemctl enable ufw.service

# paru --skipreview
sudo pacman -S --noconfirm --needed base-devel

if ! command -v paru &>/dev/null; then
    echo "Installing paru..."
    git clone https://aur.archlinux.org/paru.git
    pushd paru
    makepkg -si
    popd
    rm -r paru
fi

paru --skipreview -S --noconfirm --needed lightdm-mini-greeter google-chrome

# media
sudo pacman -S --noconfirm --needed bluez blueman bluez-utils alsa-utils vlc playerctl

# PDF
paru --skipreview -S --noconfirm --needed pandoc ghostscript

# tools & system
sudo pacman -S --noconfirm --needed cmake ntfs-3g rsync ripgrep jq xclip xdotool xorg-xprop xorg-xwininfo acpi zsh xcape maim feh libpng zlib poppler-glib htop nvtop aspell aspell-en npm cronie brightnessctl xautolock python

# latex
sudo pacman -S --noconfirm --needed texlive-most

# power management
paru --skipreview -S --noconfirm --needed auto-cpufreq-git
sudo systemctl enable --now auto-cpufreq.service

# CUDA
sudo pacman -S --noconfirm --needed nvidia nvidia-settings nvidia-utils cudnn

# fonts
sudo pacman -S --noconfirm --needed ttc-iosevka ttc-iosevka-ss04 ttf-fira-code powerline-fonts

# emacs
paru --skipreview -S --noconfirm --needed emacs-gtk3-native-comp-git-stable

# emacs server
systemctl --user enable emacs

# doom emacs
ln -s $HOME/dotfiles/doom $HOME/.config
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs
~/.config/emacs/bin/doom install

# zsh
chsh -s /usr/bin/zsh
curl -L git.io/antigen >$HOME/antigen.zsh                                                 # install antigen
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions # plugin
git clone git@github.com:wulfgarpro/history-sync.git $HOME/.zsh/history-sync              # plugin
git clone git@github.com:Szkered/.zsh_history.git $HOME/.zsh_history_proj
git clone git@github.com:Szkered/pass-store.git $HOME/.password-store

# vpn
sudo pacman -S --noconfirm --needed trojan
paru --skipreview -S --noconfirm --needed cisco-anyconnect

# dropbox
sudo pacman -S --noconfirm --needed python-gpgme
paru --skipreview -S --noconfirm --needed dropbox
sudo cp dropbox.service /etc/systemd/system
systemctl --user enable dropbox.service

# email
sudo pacman -S --noconfirm --needed openssl mu mbsync

# chinese
sudo pacman -S --noconfirm --needed fcitx5-im fcitx5-rime fcitx5-table-extra fcitx5-chinese-addons fcitx5-pinyin-zhwiki adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts noto-fonts

# install files
gpg2 --decrypt networks/trojan-config.json.gpg | sudo tee /etc/trojan/config.json

# Todos after installation:
# 1. change /etc/makepkg.conf to enable multi thread build
# 2. for laptop install xf86-video-intel
# 5. link files
# 5. run install_pkgs.sh
