# desktop
sudo pacman -Syy xorg lightdm lightdm-gtk-greeter\
    xmonad xmonad-contrib xmobar dmenu picom nitrogen chromium alacritty\
    rofi rofi-emoji papirus-icon-theme

sudo systemctl enable lightdm

# paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
pushd paru
makepkg -si
popd
rm -r paru

# media
sudo pacman -S bluez blueman bluez-utils alsa-utils vlc playerctl

# tools & system
sudo pacman -S cmake ntfs-3g rsync ripgrep jq xclip xdotool xorg-xprop xorg-xwininfo acpi zsh xcape\
    maim feh texlive-most libpng zlib poppler-glib htop nvtop\
    aspell aspell-en\
    npm cronie brightnessctl

# power management
paru auto-cpufreq-git
sudo systemctl enable --now auto-cpufreq.service

# CUDA
sudo pacman -S nvidia nvidia-settings nvidia-utils cudnn

# fonts
sudo pacman -S ttc-iosevka ttc-iosevka-ss04 ttf-fira-code powerline-fonts

# emacs
paru emacs-pgtk-native-comp-git

# emacs server
systemctl --user enable emacs

# doom emacs
ln -s doom $HOME/.config/doom
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.config/emacs
~/.config/emacs/bin/doom install

# zsh
chsh -s /usr/bin/zsh
curl -L git.io/antigen > $HOME/antigen.zsh # install antigen
ln -s .zshrc $HOME/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions # plugin

# xmonad
mkdir "$HOME/.xmonad"
cp -r .xmonad "$HOME/.xmonad/"

# xprofile
cp .xprofile "$HOME/.xprofile"

# vpn
sudo pacman -S networkmanager-openvpn network-manager-applet openvpn trojan
paru cisco-anyconnect
sudo cp vpnagentd.service /etc/systemd
sudo systemctl enable vpnagentd.service

# dropbox
sudo pacman -S python-gpgme
paru dropbox
sudo cp dropbox.service /etc/systemd/system
sudo systemctl enable dropbox.service

# email
sudo pacman -S openssl mu mbsync

# chinese
sudo pacman -S fcitx5-im fcitx5-rime fcitx5-table-extra fcitx5-chinese-addons fcitx5-pinyin-zhwiki\
    adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts noto-fonts

# local dictionary
ln -s .pwd $HOME/.config/emacs/.local/etc/ispell


# Todos after installation:
# 1. change /etc/makepkg.conf to enable multi thread build
# 2. for laptop install xf86-video-intel

