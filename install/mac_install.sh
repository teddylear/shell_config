#!/bin/zsh

# Installing bottom
brew tap clementtsang/bottom
brew install bottom

# TODO add installing docker

# Installing lazydocker
brew install jesseduffield/lazydocker/lazydocker

# zsh highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# TODO add ripgrep
