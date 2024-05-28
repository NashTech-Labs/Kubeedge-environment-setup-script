#!/bin/bash

# Download and extract keadm
wget https://github.com/kubeedge/kubeedge/releases/download/v1.12.1/keadm-v1.12.1-linux-amd64.tar.gz
tar -zxvf keadm-v1.12.1-linux-amd64.tar.gz

# Copy keadm to /usr/local/bin with sudo
sudo cp keadm-v1.12.1-linux-amd64/keadm/keadm /usr/local/bin/keadm

# Determine architecture and download the correct kind binary
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
elif [ "$ARCH" = "aarch64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-arm64
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Make kind binary executable and move to /usr/local/bin with sudo
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Download the latest stable release of kubectl
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl.sha256"

# Verify the kubectl binary
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Install kubectl to /usr/local/bin with sudo
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Clean up downloaded files
rm kubectl.sha256
rm -rf keadm-v1.12.1-linux-amd64.tar.gz keadm-v1.12.1-linux-amd64
rm kubectl

# Print a message indicating the script has finished
echo "Installation and setup completed successfully."
