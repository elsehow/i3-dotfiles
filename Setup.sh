#!/bin/bash

#
# Install packages
#
read -p "Installing packages. I'm going to ask for your user pass. Press enter to continue."
sudo add-apt-repository ppa:kgilmer/speed-ricer
apt-get update


echo "Downloading packages..."
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python python3-pip python3-dev ufw git curl zsh fonts-font-awesome
sudo apt-get install nitrogen rxvt-unicode gnome-screenshot polybar i3-gaps zathura
pip3 install pywal

echo "Installing Source Code Pro font..."
# Source Code Pro font
FONT_HOME=~/.local/share/fonts
echo "installing fonts at $PWD to $FONT_HOME"
mkdir -p "$FONT_HOME/adobe-fonts/source-code-pro"
(git clone \
     --branch release \
     --depth 1 \
     'https://github.com/adobe-fonts/source-code-pro.git' \
     "$FONT_HOME/adobe-fonts/source-code-pro" && \
     fc-cache -f -v "$FONT_HOME/adobe-fonts/source-code-pro")

# set xrvt colors
echo "Copying .config files"
cp -r .        ~/bin
cp -r .        ~/.zshrc
cp -r .        ~/.doom.d
cp -r .        ~/.Xresources
cp -r .config  ~/.config/i3/
cp -r .config  ~/.config/wal/
cp -r .config  ~/.config/zathura/
cp -r .config  ~/.config/polybar/
cp -r .config  ~/.config/.compton.conf
xrdb ~/.Xresources

echo "Done."
