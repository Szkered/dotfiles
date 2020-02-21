# ASSUMING the project is at ~/dotfiles

cd ~

# deps
sudo apt-get install build-essential libgtk-3-dev libxpm-dev gnutls-dev libncurses5-dev libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev texinfo cmake zsh libtool-bin libtool gnome-tweaks python-wand libmagickwand-dev librsvg2-dev

# emacs
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
./autogen.sh
./configure --with-dbus --with-gnutls --with-imagemagick --with-rsvg  --with-mailutils --with-xml2 --with-modules
make -j4
sudo make install
cd ..

# spacemacs
git clone https://github.com/syl20bnr/spacemacs .emacs.d
cd .emacs.d
git checkout develop
cd ..
ln -s ~/dotfiles/.spacemacs .spacemacs

# custom shell layer for multi-libvterm
cp ~/dotfiles/shell_layer_packages.el ~/.emacs.d/layers/+tool/shell/packages.el

# remap capslock
sudo apt-get install gcc make pkg-config libx11-dev libxtst-dev libxi-dev
git clone https://github.com/alols/xcape.git
cd xcape
make
sudo make install
cd ..
./remap.sh

# more zsh goodies
echo 'export SHELL=/bin/zsh' >> ~/.bash_profile
echo 'exec /bin/zsh -l' >> ~/.bash_profile
curl -L git.io/antigen > ~/antigen.zsh # install antigen
ln -s ~/dotfiles/.zshrc .zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions # plugin

# powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# multi-libvterm for spacemacs
git clone https://github.com/Szkered/multi-libvterm.git ~/.emacs.d/private/local/multi-libvterm

# microsoft python language server
cd .emacs.d
git clone https://github.com/microsoft/python-language-server.git
cd python-language-server/src/LanguageServer/Impl
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-3.0
dotnet build
dotnet publish -c Release -r linux-x64

# anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
bash Anaconda3-2019.10-Linux-x86_64.sh

# wireguard
sudo add-apt-repository ppa:wireguard/wireguard
sudo apt update
sudo apt install wireguard openresolv


# Post setup NOTE:
# 1. run all-the-icons-install-fonts in spacemacs
# 2. git config --global user.<name|email>
# 3. ssh-keygen -t rsa -b 4096
# 4. change fonts in gnome-tweaks
# 5. setup window snapping hotkeys
# 6. create conda env
# 7. modify ~/.spacemacs.env add WORKON_HOME
# 8. install tensorflow following this guide https://www.tensorflow.org/install/gpu
# 9. setup vpn: https://github.com/trailofbits/algo/blob/master/docs/client-linux-wireguard.md
