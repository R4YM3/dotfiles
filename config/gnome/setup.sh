#!/bin/bash

header "Gnome"

# default dark mode theme to fallback
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# install dracula theme
WANTED_THEME='Dracula'

mkdir -p ~/.themes
mkdir -p ~/.icons
mkdir -p ~/.zsh

# Download, unpack and install dracula theme
CURRENT_GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme)
if [ $CURRENT_GTK_THEME != WANTED_THEME ]; then
    wget  -P ~/.themes/ "https://github.com/dracula/gtk/archive/master.zip"
    cd ~/.themes
    unzip master
    rm master
    mv ./gtk-master ./Dracula

    gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
fi

# Download, unpack and install dracula icon theme
CURRENT_ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme)
if [ $CURRENT_ICON_THEME != WANTED_THEME ]; then
    cd ~/.icons/
    wget  -P ~/.icons/ "https://github.com/dracula/gtk/files/5214870/Dracula.zip"
    unzip *
    rm *.zip
    TODOS+=("Remove downloaded icons file in ~/.icons");

    gsettings set org.gnome.desktop.interface icon-theme "Dracula"
fi

# key repeat settings
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
gsettings set org.gnome.desktop.peripherals.keyboard delay 250

# dock smaller
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 16

# auto hide dock
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false

# default list view
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'

# set wallpaper
# TODO: folder  does not exist
gsettings set org.gnome.desktop.background picture-uri ./wallpaper.jpg

sudo apt install -y -f dconf-cli
mkdir ~/.config/terminal-themes
cd ~/.config/terminal-themes && git clone https://github.com/dracula/gnome-terminal && cd gnome-terminal && ./install.sh -s Dracula -p Default --install-dircolors

# set chrome as default browser
xdg-settings set default-web-browser google-chrome.desktop
