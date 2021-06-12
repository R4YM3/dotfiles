# My dotfiles to config Linux Ubuntu and Mac Os.
The script will check if host Ubuntu or Mac Os and setup it accordingly.

## Screenshots

### Mac OS
![alt text](https://github.com/R4YM3/dotfiles/blob/master/docs/macos-vim.png?raw=true)

## How to use:
```
git clone https://github.com/R4YM3/dotfiles.git
cd  ./dotfiles
chmod +x ./install.sh
./install.sh
```
## Projects
Within the projects folder you have the possiblity to setup you projects automatically. You can find my personal hetwebbureau client with it's projects. The `.gitignore` file is setup to ignore all other projects to prevent commiting information about private projects to Github.

### Installing projects
_First setup environment before installing projects._

Just run `./dotfiles && ./install.sh` and choose install projects.

### Adding projects
Just add a folder in `./dotfiles/projects` and add the files `install.sh` and `.aliases`

`install.sh` is sourced to install the project (it will inherit all the helpers).
`.aliases` is eventually sourced in .zshrc.

Notice the following in the example projects
- Each project installs a tmuxinator project
- Each project a aliased tmuxinator project
This will give the benefit to boot up a project with just one command, thanks to tmuxinator.
Try execute `dotfiles` after installing projects.

## Unfortunately after install there are still things you need todo.

### Linux Ubuntu

- Update capslock to behave as escape

### Mac OS

- Update capslock to behave as escape
- Set dock to auto hide
- Enable tap left-click on mousetrack
- Configure iterm2 to use theme defined in `./dotfiles/config/iterm/themes/dracula/Dracula.itermcolors`
