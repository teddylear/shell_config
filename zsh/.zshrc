export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spaceship"

plugins=(git git-aliases)

source $ZSH/oh-my-zsh.sh

# User configuration
bindkey -v
bindkey '^R' history-incremental-search-backward

# pyenv setup
export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init -)"

# Go variables
export GOPATH=$HOME/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

if [ "$TMUX" = "" ]; then tmux; fi

# Copying this function from below github README
# This will let me changes versions of java freely
# https://github.com/AdoptOpenJDK/homebrew-openjdk
jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
        java -version
 }

alias vim="nvim"
alias oldvim="\vim"

export EDITOR='vim'
export VISUAL='vim'
