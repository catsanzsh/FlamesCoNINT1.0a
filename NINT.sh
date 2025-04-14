#!/bin/bash
set -e

echo "==> Installing system dependencies..."
sudo apt update
sudo apt install -y build-essential curl wget unzip cmake python3

echo "==> Installing devkitPro pacman..."
wget https://apt.devkitpro.org/install-devkitpro-pacman
chmod +x ./install-devkitpro-pacman
sudo ./install-devkitpro-pacman
rm ./install-devkitpro-pacman

echo "==> Installing Nintendo console toolchains..."
sudo dkp-pacman -Syu --noconfirm
sudo dkp-pacman -S --noconfirm \
    gba-dev \
    nds-dev \
    3ds-dev \
    gamecube-dev \
    wii-dev \
    wiiu-dev \
    switch-dev

echo "==> Setting up environment variables..."
echo 'export DEVKITPRO=/opt/devkitpro' >> ~/.bashrc
echo 'export PATH=$DEVKITPRO/tools/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

echo "==> Installation complete."
