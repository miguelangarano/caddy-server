#!/bin/bash

### Initial setup

# Update existing list of packages
sudo apt-get update

# Install prerequisite packages which let apt use packages over HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


# Add Docker repository to APT sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package database with Docker packages from the newly added repo
sudo apt-get update

# Open ports for caddy
sudo ufw allow 80
sudo ufw allow 443


# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io


# Inform the user that a reboot or relogin is required
echo "Docker installed successfully!"
echo "You will need to reboot or log out & log back in for the group changes to take effect!"


# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker


# Display Docker version
docker --version


# Add docker compose repo
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


# Set permissions for docker compose 
sudo chmod +x /usr/local/bin/docker-compose


# Display docker compose version
docker-compose --version


echo "Docker compose installed successfully"

# Create docker shared network across docker compose files
docker network create webnet

echo "Docker network: webnet - created successfully"

# Create caddy volume
sudo docker volume create caddy_data

echo "Caddy docker volume created successfully"

# Create caddy_config and Caddyfile
mkdir caddy_config
ln -s Caddyfile ./caddy_config

echo "Created Caddyfile"


# Start caddy
docker-compose up -d

echo "Caddy server started"
