#!/usr/bin/zsh

# Installing bottom
curl -LO https://github.com/ClementTsang/bottom/releases/download/0.6.1/bottom_0.6.1_amd64.deb
# This version should change or live in a configuration file
# somewhere between scripts
sudo dpkg -i bottom_0.6.1_amd64.deb

# Installing docker from docks: https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
# Having it run on startup
sudo systemctl enable docker

# Adding current user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Installing lazydocker via docs
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# zsh highlighting
echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-syntax-highlighting/xUbuntu_19.10/ /' | sudo tee /etc/apt/sources.list.d/shells:zsh-users:zsh-syntax-highlighting.list
curl -fsSL https://download.opensuse.org/repositories/shells:zsh-users:zsh-syntax-highlighting/xUbuntu_19.10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_zsh-users_zsh-syntax-highlighting.gpg > /dev/null
sudo apt update
sudo apt install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# TODO add ripgrep
