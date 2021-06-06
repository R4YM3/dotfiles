header "install neovimm"

step "Install neovim dependecies"
python3 -m pip install --upgrade pynvim

echo "Symlink Neovim config"
mkdir -p ~/.config

ln -sf  "$DOTFILES_DIR/config/nvim/.config/nvim" ~/.config/

step  "Install Neovim package manager"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

step "Install packages"
nvim +'PlugInstall --sync' +qa

step "Configure Youcompleteme package"
cd ~/.config/nvim/plugged/youcompleteme && python3 install.py --all

step "Install fonts"
# TODO: FireCode Nerd Fron = required
cd ~/Downloads && git clone https://github.com/ryanoasis/nerd-fonts && ~/Downloads/nerd-fonts/install.sh
