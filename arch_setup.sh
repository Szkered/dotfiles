# desktop
sudo pacman -Syy xorg lightdm lightdm-gtk-greeter xmonad xmonad-contrib xmobar dmenu picom nitrogen chromium alacritty

sudo systemctl enable lightdm

# paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
pushd paru
makepkg -si
popd
rm -r paru

# media
sudo pacman -S bluez blueman bluez-utils alsa-utils vlc

# tools & system
sudo pacman -S cmake ntfs-3g rsync ripgrep jq xclip acpi zsh xcape

# fonts
sudo pacman -S ttc-iosevka ttc-iosevka-ss04 ttf-fira-code powerline-fonts

# emacs
paru emacs-pgtk-native-comp-git

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
