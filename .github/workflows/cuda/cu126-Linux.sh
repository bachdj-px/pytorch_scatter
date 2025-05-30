#!/bin/bash

OS=ubuntu2004

wget -nv https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/cuda-${OS}.pin
sudo mv cuda-${OS}.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget -nv https://developer.download.nvidia.com/compute/cuda/12.6.0/local_installers/cuda-repo-${OS}-12-6-local_12.6.0-560.28.03-1_amd64.deb
sudo dpkg -i cuda-repo-${OS}-12-6-local_12.6.0-560.28.03-1_amd64.deb
sudo cp /var/cuda-repo-${OS}-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/

sudo apt-get -qq update
sudo apt install cuda-nvcc-12-6 cuda-libraries-dev-12-6
sudo apt clean

rm -f https://developer.download.nvidia.com/compute/cuda/12.6.0/local_installers/cuda-repo-${OS}-12-6-local_12.6.0-560.28.03-1_amd64.deb
