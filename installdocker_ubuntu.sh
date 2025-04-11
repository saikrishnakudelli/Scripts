#!/bin/bash

# Colors
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# Divider
divider() {
  echo -e "${CYAN}------------------------------------------------------------${NC}"
}

# Heading
heading() {
  echo -e "\n${BLUE}🔧 $1...${NC}"
  divider
  sleep 2
}

echo -e "${GREEN}
   ____             _             _           
  |  _ \  ___   ___| | _____ _ __| |__  _   _ 
  | | | |/ _ \ / __| |/ / _ \ '__| '_ \| | | |
  | |_| | (_) | (__|   <  __/ |  | |_) | |_| |
  |____/ \___/ \___|_|\_\___|_|  |_.__/ \__, |
                                        |___/ 
${NC}"
echo -e "${YELLOW}Starting Docker installation script for Ubuntu...${NC}"
sleep 2

heading "Updating system and installing prerequisites"
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

heading "Adding Docker's official GPG key"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

heading "Setting up Docker's APT repository"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

heading "Installing Docker Engine and related tools"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

heading "Verifying Docker installation"
sudo docker run hello-world || { echo -e "${RED}❌ Docker failed to run${NC}"; exit 1; }
echo -e "${GREEN}✅ Docker is running successfully!${NC}"
sleep 2

heading "Adding current user to docker group to avoid sudo"
sudo usermod -aG docker "$USER"
echo -e "${YELLOW}⚠️  You may need to log out and log back in for changes to take effect.${NC}"

divider
echo -e "${GREEN}🎉 Docker installation and setup complete!${NC}"
echo -e "${CYAN}Run 'docker ps' to check Docker is working without sudo (after re-login).${NC}"
divider

