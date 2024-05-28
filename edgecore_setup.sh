#!/bin/bash

# Update the package list
sudo apt-get update

# Install required packages
sudo apt-get install -y ca-certificates curl

# Create the directory for the Docker keyring
sudo install -m 0755 -d /etc/apt/keyrings

# Download the Docker GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Change permissions of the keyring file
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository to the sources list
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list again
sudo apt-get update

# Install Docker packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Create the Docker group if it doesn't exist
sudo groupadd docker || true

# Add the current user to the Docker group
sudo usermod -aG docker $USER

# Refresh group membership to apply the new group without logout/login
newgrp docker <<EONG

# Download and extract keadm
wget https://github.com/kubeedge/kubeedge/releases/download/v1.12.1/keadm-v1.12.1-linux-amd64.tar.gz
tar -zxvf keadm-v1.12.1-linux-amd64.tar.gz

# Copy keadm to /usr/local/bin
sudo cp keadm-v1.12.1-linux-amd64/keadm/keadm /usr/local/bin/keadm

EONG

# Print a message indicating the script has finished
echo "Installation and setup completed successfully."
