export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spaceship"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
bindkey -v
bindkey '^R' history-incremental-search-backward

# pyenv setup
export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init -)"


# If macos, else assuming ubuntu
if [[ `uname` == "Darwin" ]]; then
    export PATH=$HOME/local/nvim/bin:$PATH
    export GOROOT=/usr/local/opt/go/libexec
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_CLEANUP=1

    # Copying this function from below github README
    # This will let me changes versions of java freely
    # https://github.com/AdoptOpenJDK/homebrew-openjdk
    jdk() {
            version=$1
            export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
            java -version
     }
else
    # This is for ubuntu
    export GOROOT=/usr/local/go

fi

# Go variables
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

if [ "$TMUX" = "" ]; then tmux; fi


#List of aliases
alias vim="nvim"
alias oldvim="\vim"
alias bat="batcat"

# Git aliases
alias gc='git checkout'
alias gcb='git checkout -b'
alias gs='git status'
alias ga='git add .'
alias gr='git rebase'
alias gp='git pull'
alias gps='git push'
alias gcm='git commit -m'

export EDITOR='vim'
export VISUAL='vim'


# Adding local config file for things that can't be checked into git
# Putting at the end of the file to override any unnecessary aliases
if test -f "$HOME/.local_zsh_config"; then
  source $HOME/.local_zsh_config
fi
