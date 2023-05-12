# desktop
sudo pacman -Syy xorg lightdm lightdm-mini-greeter xmonad xmonad-contrib xmobar dmenu picom nitrogen google-chrome-stable alacritty rofi rofi-emoji papirus-icon-theme intel-ucode ufw

# lightdm
sudo systemctl enable lightdm

# firewall
sudo ufw enable
sudo systemctl enable ufw.service

# paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
pushd paru
makepkg -si
popd
rm -r paru

# media
sudo pacman -S bluez blueman bluez-utils alsa-utils vlc playerctl

# PDF
paru pandoc ghostscript

# tools & system
sudo pacman -S cmake ntfs-3g rsync ripgrep jq xclip xdotool xorg-xprop xorg-xwininfo acpi zsh xcape maim feh libpng zlib poppler-glib htop nvtop aspell aspell-en npm cronie brightnessctl xautolock python

# latex
sudo pacman -S texlive-most biber rebiber

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
curl -L git.io/antigen >$HOME/antigen.zsh                                                 # install antigen
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions # plugin
git clone git@github.com:wulfgarpro/history-sync.git $HOME/.zsh/history-sync              # plugin

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
sudo pacman -S fcitx5-im fcitx5-rime fcitx5-table-extra fcitx5-chinese-addons fcitx5-pinyin-zhwiki adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts noto-fonts

# install files
ln -s alacritty.yaml $HOME/.config/alacritty/alacritty.yml
ln -s .antigenrc $HOME/.antigenrc
ln -s dunstrc $HOME/.config/dunst/dunstrc
ln -s isyncrc $HOME/.config/isyncrc
ln -s .pwd $HOME/.config/emacs/.local/etc/ispell # local dictionary
ln -s .xmobarrc $HOME/.xmobarrc
ln -s .xprofile $HOME/.xprofile
ln -s .zshrc $HOME/.zshrc

gpg2 --decrypt networks/trojan-config.json.gpg | sudo tee /etc/trojan/config.json

# Todos after installation:
# 1. change /etc/makepkg.conf to enable multi thread build
# 2. for laptop install xf86-video-intel
# 3. git clone git@github.com:Szkered/.zsh_history.git $HOME/.zsh_history_proj
# 4. git clone git@github.com:Szkered/pass-store.git $HOME/.password-store
