#!/bin/bash

rm -rf ~/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

cd ~/.oh-my-zsh

install_dotfile "$DOTFILES_DIR/config/zsh/.zshrc"

# downloads plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting --depth 1
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh  -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-completion# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh  -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-completion

# install nvm

if [ ! -d "$HOME/.nvm" ];then
  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"
fi
