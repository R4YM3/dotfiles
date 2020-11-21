#!/bin/bash

RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

TODOS=()

function header {
    echo
    echo ==============================
    echo
    echo "${GREEN}$1${RESET}"
    echo
    echo ==============================
    echo
}

echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    clear
    echo
    echo "Starting install..."
else
    echo "Your are not connected to the internet, retry when connected.."
    exit 1
fi

echo
echo "User password required to install packages"
sudo -v


header "Download fresh copy of dotfiles and saving it in ~/Development/HetWebbureau"
PWD=pwd
cd ~/Development/HetWebbureau/
git clone https://github.com/R4YM3/dotfiles.git
cd ./dotfiles && git pull
TODOS+=("Remove this folder $PWD, you can find a fresh copy in ~/Development/HetWebbureau");

header "Check for updates"
sudo apt update

header "Install build-essentials"
sudo apt-get install -y build-essential libssl-dev git curl cmake python3-dev make

header "Install drivers"
sudo ubuntu-drivers autoinstall

header "Setup folders"
mkdir ~/.themes
mkdir -p ~/Development/HetWebbureau
mkdir -p ~/Development/RTL/RTL
mkdir -p ~/Development/RTL/Videoland

header "Install applications"
sudo apt install -y snapd
sudo snap install chromium
sudo snap install opera
sudo snap install 1password --edge
sudo snap install slack --classic
sudo snap install teams-for-linux
sudo snap install gitkraken --classic
sudo snap install postman
sudo snap install code --classic
sudo snap install beekeeper-studio
sudo snap install spotify
sudo snap install vlc
sudo snap install skype --classic
sudo snap install discord
sudo snap install libreoffice
sudo snap install mailspring
sudo snap install icloud-for-linux

sudo apt-get install -y virtualbox

sudo apt install -y gnome-tweak-tool
TODOS+=("configure CAPS to ESCAPE");

if ! command -v google-chrome --version &> /dev/null
then
    wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ~/Downloads/google-chrome-stable_current_amd64.deb
    rm -rf ~/Downloads/google-chrome-stable_current_amd64.deb
else
    echo "Google chrome already installed"
fi

header "Install programming languages"
sudo snap install go --classic
sudo apt install -y default-jdk
sudo apt install -y nodejs

header "Install nvm"
if ! command -v google-chrome --version &> /dev/null
then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
else
    echo "nvm already installed"
fi

header "Install and config npm"
if ! command -v npm --version &> /dev/null
then
    sudo apt-get install -y npm
    npm config set prefix ~/.config/npm
    export NPM_CONFIG_PREFIX=~/.config/npm
    export PATH=$PATH:~/.config/npm/bin
    echo -e "export NPM_CONFIG_PREFIX=~/.config/npm\nexport PATH=\$PATH:~/.config/npm/bin" >> ~/.bashrc
else
    echo "npm already installed"
fi

header "Install CLI programs"
sudo snap install glow
sudo snap install slack-term
sudo snap install gotop
sudo snap install doctl
sudo snap install heroku --classic
sudo apt-get install -y catimg
sudo apt-get install -y kubectl
sudo apt-get install -y git-crypt
sudo apt-get install -y lynx
sudo apt-get install -y neovim
sudo apt-get install -y tmux
sudo apt-get install -y awscli
sudo apt-get install -y mono-xbuild

if ! command -v docker &> /dev/null
then
    header "Install docker"
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    apt-cache policy docker-ce
    sudo apt install -y docker-ce
else
    echo "docker already installed"
fi

header "Install global npm packages"
if ! command -v nodemon --version &> /dev/null
then
    npm install -g nodemon
else
    echo "docker already installed"
fi

sudo apt --fix-broken install -y
sudo apt autoremove -y

header "Install zsh"
if ! command -v zsh --version &> /dev/null
then
    rm -rf ~/.oh-my-zsh
    sudo apt install -y zsh
    sudo apt-get install -y powerline fonts-powerline
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
else
    echo "zsh already installed"
fi

header "Update zsh"
cd .oh-my-zsh
omz update

header "Install dotfiles"
rm ~/.zshrc

cd ~/Development/HetWebbureau/dotfiles-master
CPATH="$(pwd)/dotfiles"
DOTFILES=$(cd ./dotfiles && ls -A | egrep '^\.')

for FILE in $DOTFILES
do
  rm -rf ~/$FILE
  ln -s $CPATH/$FILE ~/$FILE
  echo "created symlink ~/$FILE refers to $CPATH/$FILE"
done

header "Install zsh plugins"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting --depth 1
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

header "(re-)install plug (Vim package manager)"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

header "Install Vim plugins"
vim +'PlugInstall --sync' +qa

header "Configure vim plugins"
cd ~/.config/nvim/plugged/youcompleteme && python3 install.py --all

header "Install fonts (will take some time)"
sudo apt install -y fonts-firacode
cd ~/Downloads && git clone https://github.com/ryanoasis/nerd-fonts && ~/Downloads/nerd-fonts/install.sh
TODOS+=("Set Gnome terminal font into: FiraCode Nerd Font Mono Regular");

header "Configure gnome"

# default dark mode theme to fallback
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# install dracula theme
WANTED_THEME='Dracula'

CURRENT_GTK_THEME=gsettings get org.gnome.desktop.interface gtk-theme "Dracula"
if [ $CURRENT_GTK_THEME != WANTED_THEME ]; then
    cd ~/.themes/                                                 && \
    curl -sS https://github.com/dracula/gtk/archive/master.zip > file.zip && \
    unzip file.zip                                                        && \
    rm file.zip

    gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
else
  echo "Dracula gtk theme already installed"
fi

CURRENT_ICON_THEME=gsettings get org.gnome.desktop.interface icon-theme "Dracula"
if [ $CURRENT_ICON_THEME != WANTED_THEME ]; then
    cd ~/.icons/                                                        && \
    curl -sS https://github.com/dracula/gtk/files/5214870/Dracula.zip > file.zip && \
    unzip file.zip                                                               && \
    rm file.zip

    gsettings set org.gnome.desktop.interface icon-theme "Dracula"
else
  echo "Dracula icon theme already installed"
fi

# key repeat settings
gsettings set org.gnome.desktop.peripherals.keyboard delay 250

# dock smaller
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 16

header "Check for updates"
sudo apt update -y
sudo snap refresh

header "Remove dependecies not required anymore"
sudo apt autoremove

header "initiate gnome terminal dracula theme install"
sudo apt-get install -y -f dconf-cli
mkdir ~/.config/terminal-themes
cd ~/.config/terminal-themes && git clone https://github.com/dracula/gnome-terminal && cd gnome-terminal && ./install.sh
TODOS+=("Activate dracula theme in gnome terminal");

cd $PWD # back where we started

header "Install finished";

echo
echo " You stil have TODO manually:"
echo

for TODO in "${TODOS[@]}"
do
    echo - $TODO.
done

header "Refreshing shell..."
exec zsh

