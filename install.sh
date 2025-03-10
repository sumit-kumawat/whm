#!/bin/bash
# Conzex Web Hosting Setup Script for Debian 12 / Ubuntu 22.04
# Logs: /var/log/conzex_install.log

set -e  # Exit on error
LOGFILE="/var/log/conzex_install.log"
exec > >(tee -a $LOGFILE) 2>&1  # Enable logging

### Step 1: OS Detection ###
OS=""
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unsupported OS. Exiting..."
    exit 1
fi

echo "Detected OS: $OS"
sleep 2

### Step 2: Update System ###
echo "Updating system packages..."
apt update && apt upgrade -y

### Step 3: Install Essential Packages ###
echo "Installing required dependencies..."
apt install -y curl wget git unzip zip sudo software-properties-common ufw fail2ban

### Step 4: Install CyberPanel ###
if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    echo "Installing CyberPanel..."
    sh <(curl -s https://cyberpanel.net/install.sh) <<< "1\nY\nN\nN\nN\nY\n"
    echo "CyberPanel installation completed!"
fi

### Step 5: Install Proxmox VE (Only on Debian) ###
if [[ "$OS" == "debian" ]]; then
    echo "Installing Proxmox VE..."
    echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
    apt update && apt full-upgrade -y
    apt install -y proxmox-ve postfix open-iscsi
    systemctl restart pve-cluster
    systemctl enable pve-cluster
fi

### Step 6: Install and Configure FOSSBilling ###
echo "Installing FOSSBilling..."
cd /var/www/
git clone https://github.com/FOSSBilling/FOSSBilling.git
cd FOSSBilling
php composer.phar install
chown -R www-data:www-data /var/www/FOSSBilling

### Step 7: Configure Automatic Backups (45-Day Retention) ###
echo "Setting up automated backups..."
apt install -y borgbackup
borg init --encryption=repokey /backup/
echo "0 3 * * * borg create --compression lz4 /backup::\$(date +\%Y-\%m-\%d) /var/www/ --keep-within=45d" | crontab -

### Step 8: Security Enhancements ###
echo "Setting up security configurations..."
apt install -y csf fail2ban
csf -r
systemctl restart fail2ban

### Step 9: Install Monitoring Tools (Zabbix & Prometheus with Grafana) ###
echo "Installing monitoring tools..."
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf grafana prometheus
systemctl enable zabbix-server grafana-server prometheus
systemctl restart zabbix-server grafana-server prometheus

### Step 10: Install WordPress for Client Portal ###
echo "Installing WordPress for client portal..."
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz -C /var/www/
chown -R www-data:www-data /var/www/wordpress

### Step 11: System Security & Firewall ###
echo "Configuring firewall rules..."
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable

### Completion ###
echo "✅ All services installed successfully! 🚀"
