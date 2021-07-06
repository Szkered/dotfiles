# ASSUMING the project is at ~/dotfiles

cd ~

# deps
sudo apt-get install -y build-essential libgtk-3-dev libxpm-dev gnutls-dev libncurses5-dev libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev texinfo cmake zsh libtool-bin libtool gnome-tweaks libmagickwand-dev librsvg2-dev libjansson-dev dropbox texlive texlive-xetex texlive-science texlive-fonts-extra latexmk libcurl4-openssl-dev libpoppler-cpp-dev libpoppler-glib-dev libpoppler-private-dev libwebkit2gtk-4.0-dev libgccjit-10-dev fd-find shellcheck jq editorconfig direnv

# emacs
git clone https://github.com/emacs-mirror/emacs.git
cd emacs
./autogen.sh
# ./configure --with-native-compilation --with-dbus --with-gnutls --with-imagemagick --with-rsvg  --with-mailutils --with-xml2 --with-modules --with-xwidgets --with-json
export CC=/usr/bin/gcc-10 CXX=/usr/bin/gcc-10
./configure --with-cairo --with-modules --with-dbus --without-compress-install --with-x-toolkit=no --with-gnutls --without-gconf --without-xwidgets --without-toolkit-scroll-bars --without-xaw3d --without-gsettings --with-mailutils --with-native-compilation --with-json --with-harfbuzz --with-imagemagick --with-jpeg --with-png --with-rsvg --with-tiff --with-wide-int --with-xft --with-xml2 --with-xpm CFLAGS="-O3 -mtune=native -march=native -fomit-frame-pointer" prefix=/usr/local
make -j `nproc` NATIVE_FULL_AOT=1
sudo make install
cd ..

# spacemacs
# git clone https://github.com/syl20bnr/spacemacs .emacs.d
# cd .emacs.d
# git checkout develop
# cd ..
# ln -s ~/dotfiles/.spacemacs .spacemacs

# custom shell layer for multi-libvterm
# cp ~/dotfiles/shell_layer_packages.el ~/.emacs.d/layers/+tool/shell/packages.el

# doom emacs
git clone git@github.com:Szkered/.doom.d.git
cd .doom.d
git submodule update --init --recursive
cd ..
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# remap capslock
sudo apt-get install -y gcc make pkg-config libx11-dev libxtst-dev libxi-dev
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
# git clone https://github.com/Szkered/multi-libvterm.git ~/.emacs.d/private/local/multi-libvterm

# microsoft python language server
cd .emacs.d
git clone https://github.com/microsoft/python-language-server.git
cd python-language-server/src/LanguageServer/Impl
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-3.1
dotnet build
dotnet publish -c Release -r linux-x64

# anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
bash Anaconda3-2021.05-Linux-x86_64.sh

# wireguard
sudo add-apt-repository ppa:wireguard/wireguard
sudo apt update
sudo apt install -y wireguard openresolv

# generate ssh key
ssh-keygen -t rsa -b 4096

# Add NVIDIA package repositories
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo dpkg -i cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
sudo apt-get update
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt install -y ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt-get update

# nvidia stuff
sudo apt install -y system76-cuda-latest
sudo apt-get install -y libcudnn7 libcudnn7-dev
sudo apt-get install -y libnvinfer6 libnvinfer-dev libnvinfer-plugin6
cd /usr/local/cuda-10.2/lib64
sudo ln -s libcudart.so.10.2.89 libcudart.so.10.1 # for tensorflow 2.1
cd ~

# conda env with tensorflow
conda create -n tf2 python=3.6
conda activate tf2
echo "WORKON_HOME=/home/zekun/anaconda3/envs" >> ~/.spacemacs.env
pip install tensorflow
mkdir ~/.local/virtual-site-packages
ln -s ~/anaconda3/envs/tf2/lib/python3.6/site-packages/tensorflow_core ~/.local/virtual-site-packages/tensorflow

# kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
rm -rf $HOME/.kube # Configure access to kubernetes API
mkdir -p $HOME/.kube

# trojan
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)"


# Post setup NOTE:
# 1. run all-the-icons-install-fonts in spacemacs
# 2. git config --global user.<name|email>
# 3. add ssh to github/gitlab
# 4. change fonts in gnome-tweaks
# 5. setup window snapping hotkeys
# 6. setup vpn: https://github.com/trailofbits/algo/blob/master/docs/client-linux-wireguard.md
#   a. download conf file
#   b. sudo install -o root -g root -m 600 ~/Downloads/zekun.conf /etc/wireguard/wg0.conf
#   c. setup kubernetes:
       # sudo scp neuri@192.168.100.74:/home/neuri/admin.conf $HOME/.kube/config
       # sudo chown $(id -u):$(id -g) $HOME/.kube/config
# 7. Set up onedrive: https://gist.github.com/starlinq/0f98c6d9339497bb8ac42d67f66f60eb

