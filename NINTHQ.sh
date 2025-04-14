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

echo "==> Installing Nintendo console toolchains (GBA to Switch)..."
sudo dkp-pacman -Syu --noconfirm
sudo dkp-pacman -S --noconfirm \
    gba-dev \
    nds-dev \
    3ds-dev \
    gamecube-dev \
    wii-dev \
    wiiu-dev \
    switch-dev

echo "==> Installing cc65 for NES..."
cd $HOME
wget https://sourceforge.net/projects/cc65/files/cc65-snapshot-src.tar.gz/download -O cc65.tar.gz
tar -xf cc65.tar.gz
rm cc65.tar.gz
cd cc65-snapshot*/src
make
sudo make install

echo "==> Installing WLA-DX for SNES/Genesis..."
cd $HOME
wget https://www.villehelin.com/wla-dx/wla-dx-10.2.tar.gz
tar -xf wla-dx-10.2.tar.gz
cd wla-dx-10.2
make
sudo make install

echo "==> Setting up environment variables..."
if ! grep -q "DEVKITPRO" ~/.bashrc; then
  echo 'export DEVKITPRO=/opt/devkitpro' >> ~/.bashrc
  echo 'export DEVKITA64=$DEVKITPRO/devkitA64' >> ~/.bashrc
  echo 'export PATH=$DEVKITPRO/tools/bin:$DEVKITA64/bin:$PATH' >> ~/.bashrc
fi
source ~/.bashrc

echo
echo "🎮 Installation complete!"
echo "🧱 Installed toolchains:"
echo "  NES     - cc65"
echo "  SNES    - WLA-DX"
echo "  GBA     - devkitARM"
echo "  NDS     - devkitARM"
echo "  3DS     - devkitARM + 3ds-dev"
echo "  GameCube- devkitPPC"
echo "  Wii     - devkitPPC"
echo "  Wii U   - devkitPPC"
echo "  Switch  - devkitA64"
