#!/bin/zsh

# Installing bottom
brew tap clementtsang/bottom
brew install bottom

# TODO add installing docker

# Installing lazydocker
brew install jesseduffield/lazydocker/lazydocker

# zsh highlighting
brew install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# TODO add ripgrep
