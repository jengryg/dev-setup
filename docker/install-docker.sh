#!/bin/bash

# get the path to the mounted user directory from windows
windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
setupPath="$windowsUserHome/.dev-setup"

# https://docs.docker.com/engine/install/ubuntu/

# 1. Set up Docker's apt repository.
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# 2. Install the Docker packages.
sudo apt-get -y install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# 3. Verify that the installation is successful by running the hello-world image:
sudo docker run hello-world

# ensure the configuration directory for the daemon exists
mkdir -p /etc/docker

# copy the configuration files
cp "$setupPath/docker/config/daemon.json" "/etc/docker/daemon.json"

# ensure that the ssl directory exists
mkdir -p /etc/docker/ssl

# copy the ssl files
cp "$setupPath/docker-ssl/ca.pem" "/etc/docker/ssl/ca.pem"
cp "$setupPath/docker-ssl/server-cert.pem" "/etc/docker/ssl/server-cert.pem"
cp "$setupPath/docker-ssl/server-key.pem" "/etc/docker/ssl/server-key.pem"