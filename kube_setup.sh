#!/bin/bash
#
# install kubernetes client

# Install pre-requisites
sudo apt update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add signing keys
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
curl -s -L https://nvidia.github.io/kubernetes/gpgkey | sudo apt-key add -

# Add repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo touch /etc/apt/sources.list.d/kubernetes.list
echo "deb http://apt.kubernetes.io/ kubernetes-bionic main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

# Install kubernetes
sudo apt-get install -y kubectl

# Configure access to kubernetes API
rm -rf $HOME/.kube

mkdir -p $HOME/.kube
sudo scp neuri@192.168.100.74:/home/neuri/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
