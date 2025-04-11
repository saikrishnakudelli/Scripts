#!/bin/bash

# 🎨 Colors
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# 📏 Divider line
divider() {
  echo -e "${CYAN}------------------------------------------------------------${NC}"
}

# 🔧 Section heading
heading() {
  echo -e "\n${BLUE}📦 $1...${NC}"
  divider
  sleep 1
}

# ⏳ Loading animation with dots
loading() {
  local message=$1
  echo -ne "${BLUE}🔄 $message${NC}"
  for i in {1..3}; do
    echo -ne "."
    sleep 0.5
  done
  echo ""
}

# 🚀 Banner
echo -e "${GREEN}
  _  __     _         _      _       
 | |/ /__ _| |_ _  _ (_)__ _| |_ ___ 
 | ' </ _\` |  _| || || / _\` |  _/ -_)
 |_|\\_\\__,_|\\__|\\_,_|/ \\__,_|\\__\\___|
                   |__/              
${NC}"
echo -e "${YELLOW}Starting kubectl installation for Linux (amd64)...${NC}"
sleep 2

# 🧩 Step 1: Download kubectl
heading "Downloading latest kubectl binary"
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# 🔐 Step 2: Download checksum
heading "Downloading checksum file"
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# ✅ Step 3: Validate binary
heading "Validating the checksum"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check || {
  echo -e "${RED}❌ Checksum validation failed! Aborting installation.${NC}"
  exit 1
}

# ⚙️ Step 4: Install kubectl
loading "Installing kubectl binary"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# 🎉 Final message
divider
echo -e "${GREEN}✅ kubectl installed successfully!${NC}"
echo -e "${CYAN}Run 'kubectl version --client' to verify installation.${NC}"
divider

