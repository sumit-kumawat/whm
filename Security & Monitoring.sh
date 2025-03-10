#!/bin/bash
# Conzex Security & Monitoring Setup Script

set -e  # Exit on error

### Step 1: Update System ###
echo "Updating system packages..."
apt update && apt upgrade -y

### Step 2: Install Security Tools (CSF, Fail2Ban) ###
echo "Installing security tools..."
apt install -y csf fail2ban
csf -r
systemctl restart fail2ban

### Step 3: Disable IPv6 ###
echo "Disabling IPv6..."
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf

### Step 4: Install Monitoring Tools (Zabbix, Prometheus, Grafana) ###
echo "Installing monitoring tools..."
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf grafana prometheus
systemctl enable zabbix-server grafana-server prometheus
systemctl restart zabbix-server grafana-server prometheus

### Step 5: Open Firewall for Monitoring Services ###
echo "Configuring firewall..."
ufw allow 10051/tcp  # Zabbix
ufw allow 9090/tcp   # Prometheus
ufw allow 3000/tcp   # Grafana
ufw enable

### Final Message ###
echo -e "\n==============================="
echo "Security & Monitoring Tools Installed Successfully!"
echo "Access Grafana: http://your-server-ip:3000"
echo "==============================="
