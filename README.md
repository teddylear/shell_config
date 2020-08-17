# My bash config
## zsh
Install [oh-my-zsh](https://ohmyz.sh/)

Install [spaceship theme](https://github.com/denysdovhan/spaceship-prompt)

## stow
Remove *.vimrc* and *.zshrc* from the home directory
run 
```
stow vim
stow zsh
```

## vim 
Open vim and run *:PluginInstall*

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
* brew install stow
* link all directories in configuration folder
* brew install tmux
* brew install pyenv
* brew install node
* brew install yarn
* Then run *:PluginInstall* on vim so that all the plugins are installed
* Then restart browser
