#!/bin/bash
# Conzex VPS (Proxmox VE) Setup Script

set -e  # Exit on error

### Step 1: Update System ###
echo "Updating system packages..."
apt update && apt upgrade -y

### Step 2: Install Proxmox VE ###
echo "Installing Proxmox VE..."
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
apt update && apt full-upgrade -y
apt install -y proxmox-ve postfix open-iscsi

### Step 3: Enable Required Services ###
echo "Enabling Proxmox Services..."
systemctl restart pve-cluster
systemctl enable pve-cluster

### Step 4: Disable IPv6 ###
echo "Disabling IPv6..."
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf

### Step 5: Open Necessary Ports ###
echo "Configuring firewall rules..."
ufw allow 8006/tcp  # Proxmox Web UI
ufw allow 22/tcp    # SSH
ufw enable

### Final Message ###
echo -e "\n==============================="
echo "Proxmox VE Installed Successfully!"
echo "Access Proxmox UI: https://your-server-ip:8006"
echo "==============================="
