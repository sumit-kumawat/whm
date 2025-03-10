#!/bin/bash
# Proxmox VE Installation Script for Debian 12
# This script installs Proxmox VE and configures necessary dependencies

set -e  # Exit on error

### Step 1: Update System ###
echo "Updating system packages..."
apt update && apt upgrade -y

### Step 2: Install Required Dependencies ###
echo "Installing required dependencies..."
apt install -y curl wget git sudo software-properties-common

### Step 3: Add Proxmox VE Repository & GPG Key ###
echo "Adding Proxmox VE repository..."
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list

# Add the Proxmox GPG key
echo "Adding Proxmox VE GPG Key..."
wget -qO- https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg | tee /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg > /dev/null

### Step 4: Install Proxmox VE ###
echo "Installing Proxmox VE..."
apt update && apt install -y proxmox-ve postfix open-iscsi

systemctl restart pve-cluster
systemctl enable pve-cluster

### Step 5: Disable IPv6 ###
echo "Disabling IPv6..."
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

### Completion ###
echo "Proxmox VE installation completed successfully! 🚀"

