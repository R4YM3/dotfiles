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

### Installing projects
_First setup environment before installing projects._

Just run `./dotfiles && ./install.sh` and choose install projects.

### Adding projects
Just add a folder in `./dotfiles/projects` and add the files `install.sh` and `.aliases`

## Unfortunately after install there are still things you need todo.

### Linux Ubuntu

- Update capslock to behave as escape

### Mac OS

- Update capslock to behave as escape
- Set dock to auto hide
- Enable tap left-click on mousetrack
- Configure iterm2 to use theme defined in `./dotfiles/config/iterm/themes/dracula/Dracula.itermcolors`
