# Conzex Web Hosting Setup Script

## Overview
This script automates the setup of a complete web hosting infrastructure on a **single Debian 12 server**. It installs and configures:

- **CyberPanel** (Accessible via `cpanel.conzex.com`)
- **Proxmox VE** for VPS hosting and automation
- **FOSSBilling** with full branding and integration
- **Automated backups** (45-day retention)
- **Security enhancements** (CSF, Fail2Ban, SSL, Firewalls)
- **Monitoring tools** (Zabbix, Prometheus, Grafana)
- **WordPress** for a Hostinger-like client portal

## Prerequisites
- A **Debian 12** server (Recommended: Dell PowerEdge R610)
- A domain (`conzex.com`) and subdomain (`cpanel.conzex.com`)
- Basic Linux knowledge for managing the server

## Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/sumit-kumawat/whm/blob/main/install.sh
   cd conzex-whm
   ```
2. **Make the script executable:**
   ```bash
   chmod +x setup.sh
   ```
3. **Run the script:**
   ```bash
   ./setup.sh
   ```

## Post-Installation
- Access **CyberPanel**: `https://cpanel.conzex.com`
- Login to **Proxmox VE**: `https://your-server-ip:8006`
- Manage billing via **FOSSBilling**: `https://your-server-ip/fossbilling`
- Client portal via **WordPress**: `https://your-server-ip`
- Monitoring via **Grafana**: `https://your-server-ip:3000`

## Support
For any issues, contact **support@conzex.com**.

