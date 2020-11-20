# install:
sudo apt update
sudo apt-get install build-essential libssl-dev git curl cmake python3-dev make

# drivers
sudo ubuntu-drivers autoinstall
drivers ethernet drivers

# applications
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

wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ~/Downloads/google-chrome-stable_current_amd64.deb
rm -rf ~/Downloads/google-chrome-stable_current_amd64.deb


# languages
sudo snap install go --classic
sudo apt install -y default-jdk
sudo apt install -y nodejs

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash

sudo apt-get install npm
npm config set prefix ~/.config/npm
export NPM_CONFIG_PREFIX=~/.config/npm
export PATH=$PATH:~/.config/npm/bin
echo -e "export NPM_CONFIG_PREFIX=~/.config/npm\nexport PATH=\$PATH:~/.config/npm/bin" >> ~/.bashrc

# cli
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

# to remap caps lock into esc
sudo apt install gnome-tweak-tool

# docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt-cache policy docker-ce
sudo apt install -y docker-ce

# global packages
npm install -g nodemon
npm install -g trash

# linux behaviour

# key repeat settings
gsettings set org.gnome.desktop.peripherals.keyboard delay 250

# caps as escape
setxkbmap -option caps:swapescape

# setup folders
mkdir ~/.config
mkdir ~/.themes
mkdir -p ~/Development/HetWebbureau
mkdir -p ~/Development/RTL/RTL
mkdir -p ~/Development/RTL/Videoland

# install zsh
sudo apt install -y zsh
sudo apt-get install -y powerline fonts-powerline
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# enable zsh
chsh -s /bin/zsh
exec zsh

# update zsh
cd .oh-my-zsh
omz update

# zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting --depth 1
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install dotfiles
CPATH="$(pwd)/dotfiles"
DOTFILES=($(cd ./dotfiles && ls -A | egrep '^\.')) # parentheses are required

for FILE in "${DOTFILES[@]}"
do
  rm -rf ~/$FILE
  ln -s $CPATH/$FILE ~/$FILE
  echo "created symlink ~/$FILE refers to $CPATH/$FILE"
done

exec zsh

# install plug, vim package manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install vim packages
nvim +PluginInstall +qall

# install font
sudo apt install -y fonts-firacode
cd ~/Downloads && git clone https://github.com/ryanoasis/nerd-fonts && ~/Downloads/nerd-fonts/install.sh

# config color schemes
cp -r ~/.config/nvim/plugged/vim-colors-solarized ~/.config/nvim/colors/

# config youcompleteme
cd ~/.config/nvim/plugged/youcompleteme && python3 install.py --all

# check for updates
sudo apt update
sudo snap refresh

# install terminal dracula theme
sudo apt-get install -f dconf-cli
mkdir ~/.config/terminal-themes
cd ~/.config/terminal-themes && git clone https://github.com/dracula/gnome-terminal && cd gnome-terminal && ./install.sh
