echo "SETUP TMUXINATOR   SYMLINKS??"

TMUXINATOR_CONFIG_PROJECTS_DIR="$DOTFILES_DIR/config/tmuxinator/projects"

install_tmuxinator_project "$TMUXINATOR_CONFIG_PROJECTS_DIR/example.yml"
install_tmuxinator_project "$TMUXINATOR_CONFIG_PROJECTS_DIR/new-project.yml"
