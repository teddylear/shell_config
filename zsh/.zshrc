# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export PATH="$HOME/.local/bin:$PATH"
# export PATH="/usr/local/bin:$PATH"

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  . $HOME/.nix-profile/etc/profile.d/nix.sh;
  # export PATH="$HOME/.nix-profile/bin:$PATH"
fi # added by Nix installer

# Use `zprof` to profile zsh starting up
zmodload zsh/zprof
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(evalcache git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh


# User configuration
bindkey -v

# Mcfly configuration
export MCFLY_KEY_SCHEME=vim
export MCFLY_RESULTS=20
# TODO: Should this be back to just `eval`?
_evalcache mcfly init zsh

# pyenv setup
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
_evalcache pyenv init -

# export PATH=$HOME/.pkenv/bin:$PATH
# export PATH=$HOME/.tfenv/bin:$PATH

# If macos, else assuming ubuntu
if [[ `uname` == "Darwin" ]]; then
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_CLEANUP=1
    _evalcache pyenv init --path

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
    # export PATH="$PATH:$HOME/node_modules/.bin"
fi

# Go variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
# export PATH=$PATH:$GOPATH/bin
# export PATH=$GOROOT/bin:$PATH

#List of aliases
alias vim="nvim"
alias oldvim="\vim"
# alias bat="batcat"
alias tfclean="rm -rf .terraform; rm plan.out"

# fzf
export FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob=\!.git"
alias p='nvim `fzf --reverse --preview="bat --color always {}"`'

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
alias gr='git restore'
alias gp='git pull'
alias gps='git push'
alias gcm='git commit -m'
# From devaslife dotfiles
alias ll='eza -l -g -a --icons'


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

# For Rust
if [ -d "$HOME/.cargo" ]; then
    # export PATH=$HOME/local/.cargo/bin:$PATH
    # source $HOME/.cargo/env
fi

# Adding local config file for things that can't be checked into git
# Putting at the end of the file to override any unnecessary aliases
if test -f "$HOME/local_zsh_config.zsh"; then
  source $HOME/local_zsh_config.zsh
fi

# From: https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# From Thorsten Ball for using github cli
pr() {
  if type gh &> /dev/null; then
    gh pr view -w
  else
    echo "gh is not installed"
  fi
}

propen() {
  if type gh &> /dev/null; then
    local git_commit_text=$(git log -1 --pretty=%B)
    gh pr create --draft --title $git_commit_text --body $git_commit_text
    pr
  else
    echo "gh is not installed"
  fi
}

# export PATH="$HOME/.nix-profile/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
