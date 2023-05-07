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
sudo pacman -S cmake ntfs-3g rsync ripgrep jq xclip acpi zsh

# zsh
echo 'export SHELL=/bin/zsh' >> ~/.bash_profile
echo 'exec /bin/zsh -l' >> ~/.bash_profile
curl -L git.io/antigen > ~/antigen.zsh # install antigen
ln -s ~/dotfiles/.zshrc .zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions # plugin

cp .xprofile "$HOME/.xprofile"
mkdir "$HOME/.xmonad"
cp -r .xmonad "$HOME/.xmonad/"
