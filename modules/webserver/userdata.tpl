#!/bin/bash
sudo apt update -y &&
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
sudo export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
sudo [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
sudo nvm install 18
git clone https://github.com/linhnt/posts.git
cd posts
sudo npm install -y
sudo npm install pm2 -g.
pm2 start dist/main.js --name posts
