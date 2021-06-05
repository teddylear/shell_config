# My bash config
## zsh
Install [oh-my-zsh](https://ohmyz.sh/)

Install [spaceship theme](https://github.com/denysdovhan/spaceship-prompt)

Always install lastest release of neovim!!!!!!!!!!!!!!

## stow
Remove *.vimrc* and *.zshrc* from the home directory
run
```
stow nvim
stow zsh
stow tmux
stow alacritty
```

## neo vim
Run this command to install the plug extension for neovim
```bash
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip
```

Open vim and run *:PlugInstall*
```
:PlugInstall
:UpdateRemotePlugins

# For languages supported by treesitter
:TSInstall {language}
```
Note for coc-python first time trying to rename a variable, need to install rope in buffer


## Tmux
In the home directory
```bash
brew install tmux
# tmux plugins manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

To install the tmux plugins, use tmux prefix (CTRL + W) + I

## What if I have local config that I don't want checked in?
This configuration should be added to the *.local_zsh_config* in your *$HOME*
directory. If this file does not exist, then it won't be loaded. This is loaded
after all of the zshrc configuration, so if there any overrides they are applied

# List of setup commands for mac
* Clone repo with configuration in home directory
* install oh-my-zsh, vim
* git clone https://github.com/peterhurford/git-aliases.zsh.git ~/.oh-my-zsh/custom/plugins/git-aliases
* brew install stow
* link all directories in configuration folder
* brew install tmux
* brew install pyenv
* brew install hashicorp/tap/terraform-ls
* brew install go
* brew install pylint
* brew install ripgrep
* brew install tree
* pip install pynvim --upgrade
* pip install python-language-server
* pip install -U jedi-language-server
* brew tap homebrew/cask-fonts
* brew cask install font-hack-nerd-font
* Set iterm2 to use 'Hack Nerd Font' font size 14
* mkdir Go (At home directory)
* git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
* Then run *:PluginInstall* on vim so that all the plugins are installed
* Install alacritty terminal
* Then restart terminal

# Ubuntu specific stuff
Currently using Ubuntu 20 with MATE desktop and i3 for window management

```
stow compton
stow i3
```

TODO have to add steps and automate the setup of linking compton & i3

## i3

Install i3 via normal means

Set i3 as default window manager in mate [following this article](https://mattgreer.dev/blog/mate-and-i3/)

For i3 gaps follow this [github gist](https://gist.github.com/dabroder/813a941218bdb164fb4c178d464d5c23)

# Installation

For mac run
```
./install/mac_install.sh
```

For ubuntu run
```
./install/mac_install.sh
```
