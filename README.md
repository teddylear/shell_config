# My bash config
## zsh
Install [oh-my-zsh](https://ohmyz.sh/)

Install [spaceship theme](https://github.com/denysdovhan/spaceship-prompt)

## stow
Remove *.vimrc* and *.zshrc* from the home directory
run
```
stow nvim
stow zsh
stow tmux
```

## neo vim
Open vim and run *:PlugInstall*

Run this command to install the plug extension for neovim
```bash
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Tmux
In the home directory
```bash
brew install tmux
# tmux plugins manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

# List of setup commands
* Clone repo with configuration in home directory
* install oh-my-zsh, vim
* git clone https://github.com/peterhurford/git-aliases.zsh.git ~/.oh-my-zsh/custom/plugins/git-aliases
* brew install stow
* link all directories in configuration folder
* brew install tmux
* brew install pyenv
* brew install neovim
* brew install node
* brew install yarn
* brew install go
* brew install pylint
* brew tap homebrew/cask-fonts
* brew cask install font-hack-nerd-font 
* Set iterm2 to use 'Hack Nerd Font' font size 14
* mkdir Go (At home directory)
* git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
* Then run *:PluginInstall* on vim so that all the plugins are installed
* Then restart terminal
