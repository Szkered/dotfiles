#!/usr/bin/env sh
# following the instruction here: https://wiki.archlinux.org/title/NVIDIA

# install CUDA packages
sudo pacman -S --noconfirm --needed nvidia nvidia-settings nvidia-utils cudnn

# Remove kms from the HOOKS array in /etc/mkinitcpio.conf
sudo sed -i '/^HOOKS/s/kms //' /etc/mkinitcpio.conf

# regenerate the initramfs
sudo mkinitcpio -P

# To avoid the possibility of forgetting to update initramfs after an NVIDIA driver upgrade, use a pacman hook:
sudo mkdir -p /etc/pacman.d/hooks
sudo cp $HOME/dotfiles/pacman-hooks/nvidia.hook /etc/pacman.d/hooks/nvidia.hook

# grub config
sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="nvidia-drm.modeset=1"/g' /etc/default/grub

# xorg config
sudo nvidia-xconfig
