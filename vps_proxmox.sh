#!/bin/bash

# Disable IPv6 before starting anything
echo "Disabling IPv6..."
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

# Define variables
PVE_REPO="deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription"
HOSTNAME="proxmox"  # Change this to your desired hostname

# Update system
apt update && apt full-upgrade -y

# Install required dependencies
apt install -y curl wget gnupg2 lsb-release software-properties-common

# Add Proxmox VE repository and key
wget -qO /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg
echo "$PVE_REPO" > /etc/apt/sources.list.d/pve.list

# Disable enterprise repository (optional for non-subscription users)
sed -i 's/^deb/#deb/g' /etc/apt/sources.list.d/pve-enterprise.list

# Update package list and install Proxmox VE
apt update && apt install -y proxmox-ve postfix open-iscsi

# Set hostname
hostnamectl set-hostname "$HOSTNAME"

# Disable conflicting services
apt remove -y os-prober
systemctl disable --now apparmor

# Configure GRUB for better performance
sed -i 's/quiet/quiet intel_iommu=on iommu=pt/g' /etc/default/grub
update-grub

# Reboot to apply changes
echo "Proxmox installation complete. Rebooting in 10 seconds..."
sleep 10
reboot
