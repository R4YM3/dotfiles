#!/bin/bash

RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

PWD=pwd

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

# ask password upfront
echo
echo "User password required to install packages"
sudo -v

# test internet connection, if not found install ethernet drivers
echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    clear
    echo
    echo "Starting install..."
else
    echo
    echo "No internet detected, installing ethernet drivers"

    DRIVERS_ETHERNET_PATH = "${PWD}/drivers/ethernet"

    echo "Installing driver dependecies"
    sudo dpkg -i "$DRIVERS_ETHERNET_PATH/dependecies"

    DRIVERS_ETHERNET_EXECUTABLE="$DRIVERS_ETHERNET_PATH/r8125-9.004.01/autorun.sh"
    sudo chmod +x $DRIVERS_ETHERNET_EXECUTABLE
    $DRIVERS_ETHERNET_EXECUTABLE

    echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        clear
        echo
        echo "Connected to Internet."
    else
        echo
        echo "ERROR: No internet detected"
        exit 1
    fi
fi

# update to latest version
header "Check for updates"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt update -y

header "Install build-essentials"
sudo apt-get install -y build-essential libssl-dev git curl cmake python3-dev make

header "Install drivers"
sudo ubuntu-drivers autoinstall

# For GPU we need specific version
header "Kernel"
KERNEL_VERSION=$(uname -r)
WANTED_KERNEL_VERSION="5.4.0-42-generic"
if [ $KERNEL_VERSION != $WANTED_KERNEL_VERSION ]
then
    echo "Found kernel $KERNEL_VERSION wanted $WANTED_KERNEL_VERSION"

    IMAGE="linux-image-${WANTED_KERNEL_VERSION}"
    HEADERS="linux-headers-${WANTED_KERNEL_VERSION}"
    MODULES_EXTRA="linux-modules-extra-${WANTED_KERNEL_VERSION}"

    sudo apt install $IMAGE $HEADERS $MODULES_EXTRA

    echo ""
    echo "installed $WANTED_KERNEL_VERSION which is the latest supported kernel by amdgpu";
    echo "please reboot into this kernel and re-run this script"

    exit 1;
fi

# tests GPU, when required install GPU drivers

if ! command -v amdgpu-uninstall --help &> /dev/null
header "GPU"
then
    echo "Please install GPU drivers"
    TODOS+=("Install GPU drivers, download it from please go to: https://www.amd.com/en/support/graphics/amd-radeon-6000-series/amd-radeon-6900-series/amd-radeon-rx-6900-xt. Download drivers, unpack and run it with sudo ./amdgpu-install -y");
else
    echo "GPU drivers are installed"
fi

# Install and config git, we need this when installing dotfiles
header "git"
if ! command -v git help &> /dev/null
then
    sudo apt install git-all -y
else
    echo "git already installed"
fi

header "Set config git"
GIT_USERNAME="Raymond Schweers"
GIT_EMAIL="raymond@hetwebbureau.nl"
GIT_CRLF="input"

header "Setup git"
git config --global user.name $GIT_USERNAME
echo "git user.name = $GIT_USERNAME"

git config --global user.email $GIT_EMAIL
echo "git user.email = $GIT_EMAIL"

# required to fix line endings in dependecies
git config --global core.autocrlf $GIT_CRLF
echo "git user.autocrlf = $GIT_CRLF"

# get last version of dotfiles
header "Download fresh copy of dotfiles and saving it in ~/Development/HetWebbureau"
cd ~/Development/HetWebbureau/
git clone https://github.com/R4YM3/dotfiles.git
cd ./dotfiles && git pull
TODOS+=("Remove this folder $PWD, you can find a fresh copy in ~/Development/HetWebbureau");

header "Setup folders"
mkdir ~/.themes
mkdir ~/.icons
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

    sudo apt install chrome-gnome-shell

    TODOS+=("Enable sync in Google Chrome");
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
sudo apt-get install -y tmuxinator
sudo apt-get install -y awscli
sudo apt-get install -y mono-xbuild
sudo apt-get install -y openssh-server
sudo apt-get install -y openconnect
sudo apt-get install -y ack-grep

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

if ! command -v tidal-cli --version &> /dev/null
then
    npm -g i tidal-cli-client@latest
else
    echo "tidal-cli already installed"
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
cd ~/.oh-my-zsh
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

CURRENT_GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme)
if [ $CURRENT_GTK_THEME != WANTED_THEME ]; then
    wget  -P ~/.themes/ "https://github.com/dracula/gtk/archive/master.zip"
    cd ~/.themes
    unzip master
    rm master
    mv ./gtk-master ./Dracula


    gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
else
    echo "Dracula gtk theme already installed"
fi

CURRENT_ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme)
if [ $CURRENT_ICON_THEME != WANTED_THEME ]; then
    cd ~/.icons/
    wget  -P ~/.icons/ "https://github.com/dracula/gtk/files/5214870/Dracula.zip"
    unzip *
    rm *.zip
    TODOS+=("Remove downloaded icons file in ~/.icons");

    gsettings set org.gnome.desktop.interface icon-theme "Dracula"
else
  echo "Dracula icon theme already installed"
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
gsettings set org.gnome.desktop.background picture-uri file:////home/picard/Development/HetWebbureau/dotfiles/wallpaper.jpg

header "Check for updates"
sudo apt update -y
sudo snap refresh

header "Remove dependecies not required anymore"
sudo apt autoremove

# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh  -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-completion

header "Download github repositories"
cd ~/Development/HetWebbureau/
git clone https://github.com/R4YM3/react-cli.git

header "initiate gnome terminal dracula theme install"
sudo apt-get install -y -f dconf-cli
mkdir ~/.config/terminal-themes
cd ~/.config/terminal-themes && git clone https://github.com/dracula/gnome-terminal && cd gnome-terminal && ./install.sh
TODOS+=("Activate dracula theme in gnome terminal");

header "Check for updates"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

cd $PWD # back where we started

TODOS+=("Install dash to dock");

header "Install finished";

echo
echo " You stil have TODO manually:"
echo

for TODO in "${TODOS[@]}"
do
    echo - $TODO.
done

google-chrome https://extensions.gnome.org/extension/307/dash-to-dock/

header "Refreshing shell..."
exec zsh
