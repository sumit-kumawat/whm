#!/bin/bash
# Conzex CyberPanel + FOSSBilling Setup Script

set -e  # Exit on error

### Step 1: Update System ###
echo "Updating system packages..."
apt update && apt upgrade -y

### Step 2: Install Essential Packages ###
echo "Installing required dependencies..."
apt install -y curl wget git unzip zip sudo software-properties-common ufw fail2ban

### Step 3: Disable IPv6 ###
echo "Disabling IPv6..."
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf

### Step 4: Install CyberPanel ###
echo "Installing CyberPanel..."
sh <(curl -s https://cyberpanel.net/install.sh) <<< "1\nY\nN\nN\nN\nY\n"
echo "CyberPanel installation completed!"

### Step 5: Install FOSSBilling ###
echo "Installing FOSSBilling..."
cd /var/www/
git clone https://github.com/FOSSBilling/FOSSBilling.git
cd FOSSBilling
php composer.phar install
chown -R www-data:www-data /var/www/FOSSBilling

### Step 6: Configure Automatic Backups (45-Day Retention) ###
echo "Setting up automated backups..."
apt install -y borgbackup
borg init --encryption=repokey /backup/
echo "0 3 * * * borg create --compression lz4 /backup::$(date +\%Y-\%m-\%d) /var/www/ --keep-within=45d" | crontab -

### Step 7: Enable Security Measures ###
echo "Setting up security configurations..."
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable

### Final Message ###
echo -e "\n==============================="
echo "CyberPanel + FOSSBilling Installed Successfully!"
echo "Access CyberPanel: https://cpanel.conzex.com"
echo "==============================="
