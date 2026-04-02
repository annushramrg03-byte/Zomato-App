#!/bin/bash

set -e

echo "Updating system..."
sudo apt-get update -y

echo "Installing required packages..."
sudo apt-get install -y wget apt-transport-https gnupg

echo "Adding Trivy GPG key..."
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

echo "Adding Trivy repository..."
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" \
  | sudo tee /etc/apt/sources.list.d/trivy.list

echo "Updating package list..."
sudo apt-get update -y

echo "Installing Trivy..."
sudo apt-get install -y trivy

echo "Trivy installation completed!"
echo "Check version:"
trivy --version
