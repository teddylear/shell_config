export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spaceship"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:$PATH"

# User configuration
bindkey -v

# Mcfly configuration
export MCFLY_KEY_SCHEME=vim
export MCFLY_RESULTS=20
eval "$(mcfly init zsh)"

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"

export PATH=$HOME/.pkenv/bin:$PATH
export PATH=$HOME/.tfenv/bin:$PATH

# If macos, else assuming ubuntu
if [[ `uname` == "Darwin" ]]; then
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_CLEANUP=1
    eval "$(pyenv init --path)"

    # Copying this function from below github README
    # This will let me changes versions of java freely
    # https://github.com/AdoptOpenJDK/homebrew-openjdk
    jdk() {
            version=$1
            export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
            java -version
     }
else
    # This section for ubuntu
    # TODO: what did I need this for??
    export PATH="/usr/local/opt/openssl/bin:$PATH"
fi

# Node configuration if node_modules in home directory
if [ -d "$HOME/node_modules" ]; then
    export PATH="$PATH:$HOME/node_modules/.bin"
fi

# Go variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$GOROOT/bin:$PATH


#List of aliases
alias vim="nvim"
alias oldvim="\vim"
# alias bat="batcat"
alias tfclean="rm -rf .terraform; rm plan.out"

# fzf
export FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob=\!.git"
alias p='nvim `fzf --preview="bat --color always {}"`'

tfsetup() {
    echo "==> Cleaning up directory"
    tfclean
    echo "==> Running init"
    terraform init
    echo "==> Running plan"
    terraform plan -out=plan.out
}

# Git aliases
alias gsw='git switch'
alias gsc='git switch -c'
alias gs='git status'
alias ga='git add .'
alias gr='git restore'
alias gp='git pull'
alias gps='git push'
alias gcm='git commit -m'


if [ -f "$HOME/tmux-session.sh" ]
then
    export TMUX_SCRIPT_PATH="$HOME/tmux-session.sh"
else
    export TMUX_SCRIPT_PATH="$HOME/shell_config/tmux-session.sh"
fi
alias tmuxsession='zsh $TMUX_SCRIPT_PATH'
export TMUX_WIN_PATH="$HOME/code"

export EDITOR='nvim'
export VISUAL='nvim'

export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Adding local config file for things that can't be checked into git
# Putting at the end of the file to override any unnecessary aliases
if test -f "$HOME/.local_zsh_config"; then
  source $HOME/.local_zsh_config
fi

# For Rust
if [ -d "$HOME/.cargo" ]; then
    export PATH=$HOME/local/.cargo/bin:$PATH
    source $HOME/.cargo/env
fi

