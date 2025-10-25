#!/bin/bash

USER=$1

# Update package list
sudo apt-get update

echo "# Installing Docker..."
echo "---"

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker Engine
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add the current user to the docker group
sudo usermod -aG docker $USER

# Check Docker and Docker Compose versions
sudo docker --version
sudo docker-compose --version

echo "# Starting docker compose..."
echo "---"

# Navigate to the project directory and start the Docker Compose project
cd /home/$USER/project && sudo docker compose up --build -d

# Show the IP address of the VM
echo "# Setup complete! You can access the application at the following IP address:"
ip addr show eth0 | awk '/inet / {sub(/\/.*/, "", $2); print $2}'
