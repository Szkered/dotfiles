# ASSUMING the project is at ~/dotfiles

cd ~

# deps
sudo apt-get install build-essential libgtk-3-dev libxpm-dev gnutls-dev libncurses5-dev libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev texinfo cmake zsh libtool-bin libtool

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

# powerline font patch
sudo apt-get install fonts-powerline

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

# Post setup NOTE:
# 1. run all-the-icons-install-fonts in spacemacs
