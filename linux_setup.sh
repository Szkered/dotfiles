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
