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

# TODO - install i3-radius
#                picom
#
#                conky
#                gcalcli
#                drive v0.3.9.1 +

# emacs
sudo snap install emacs --classic
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# org protocol setup
gconftool-2 -s /desktop/gnome/url-handlers/org-protocol/command '/snap/bin/emacsclient %s' --type String
gconftool-2 -s /desktop/gnome/url-handlers/org-protocol/enabled --type Boolean true


echo "Setting visual preferences..."

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
crontab crontab.backup # install crontab
# NOTE this will error until you install drive!

# Set default directory for gnome-screenshot
gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/$USER/Downloads/"
echo "Done."

#
# Hardening
#

# UFW
sudo ufw default deny outgoing
sudo ufw default deny incoming
sudo ufw allow out 53
sudo ufw allow out http
sudo ufw allow out https
sudo ufw allow syncthing
sudo ufw allow out ssh # for authenticated git with keys
sudo ufw allow out 8000 # for n10.as radio
sudo ufw enable

xset r rate 160 30

echo "Done! Your TODOs:"
echo "- Start emacs, let it download, then change theme!"
echo "- Install oh-my-zsh manually."
echo "- Install drive manually: https://github.com/odeke-em/drive"
