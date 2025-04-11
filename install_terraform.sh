#!/bin/bash

# 🎨 Colors
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# 📏 Divider
divider() {
  echo -e "${CYAN}------------------------------------------------------------${NC}"
}

# 🔧 Heading
heading() {
  echo -e "\n${BLUE}🔹 $1...${NC}"
  sleep 1
}

# ⏳ Loading animation
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
echo -e "${GREEN}🔧 Installing: TERRAFORM${NC}"
echo -e "${YELLOW}Fetching from the official HashiCorp repository...${NC}"
sleep 2

# 🧩 Step 1: Prerequisites
heading "Installing prerequisites"
sudo apt-get update -y && sudo apt-get install -y gnupg software-properties-common curl

# 🔐 Step 2: Add HashiCorp GPG key
heading "Adding HashiCorp GPG key"
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# 🔍 Step 3: Verify GPG fingerprint
heading "Verifying GPG fingerprint"
gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint

# 📦 Step 4: Add HashiCorp apt repository
heading "Adding HashiCorp repository to sources list"
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

# 🔄 Step 5: Update apt cache
loading "Updating apt package index"
sudo apt-get update -y

# 🛠️ Step 6: Install Terraform
loading "Installing Terraform CLI"
sudo apt-get install -y terraform

# ✅ Step 7: Verify installation
divider
echo -e "${GREEN}✅ Terraform installation completed successfully!${NC}"
divider

# 🔍 Basic usage check
echo -e "${YELLOW}📖 Sample Terraform CLI usage:${NC}"
echo -e "${CYAN}> terraform version${NC}"
terraform version

echo -e "\n${CYAN}> terraform -help${NC}"
terraform -help | head -n 10

divider

