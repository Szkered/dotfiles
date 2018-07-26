# emacs
sudo apt-get install build-essential libgtk-3-dev libxpm-dev gnutls-dev libncurses5-dev libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev texinfo
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
./autogen.sh
./configure
make -j4
sudo make install
cd ..

# spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -s .spacemacs ~/.spacemacs

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
echo 'export SHELL=/bin/zsh' >> ~/.profile
echo 'exec /bin/zsh -l' >> ~/.profile
curl -L git.io/antigen > ~/antigen.zsh # install antigen
ln -s .zshrc $HOME/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions # plugin
