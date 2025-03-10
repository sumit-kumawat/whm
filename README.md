# Conzex Web Hosting Management (WHM)

## Overview
This repository provides automated scripts to set up and configure a complete web hosting solution using **CyberPanel**, **Proxmox VE**, and **Security & Monitoring Tools**. These scripts are designed to automate the installation and configuration of essential hosting components on **Debian 12** and **Ubuntu 22.04**.

---

## 📌 Features
- **CyberPanel + FOSSBilling**: Automates the installation of CyberPanel and FOSSBilling for web hosting and billing management.
- **VPS Hosting (Proxmox VE)**: Sets up Proxmox VE for VPS hosting and automation.
- **Security & Monitoring**: Configures CSF, Fail2Ban, Zabbix, Prometheus, and Grafana for enhanced security and system monitoring.
- **Automatic Backups**: Configures a **45-day retention** policy using **BorgBackup**.
- **Firewall and Security Enhancements**: Sets up **UFW, CSF, and Fail2Ban** for security hardening.
- **IPv6 Disabling**: Ensures consistent networking by disabling **IPv6**.

---

## 🚀 Scripts Summary
| Script Name | Purpose | Supported OS |
|------------|---------|-------------|
| **cyberpanel_fossbilling.sh** | Installs CyberPanel & FOSSBilling | Debian 12 / Ubuntu 22.04 |
| **vps_proxmox.sh** | Installs and configures Proxmox VE for VPS hosting | Debian 12 |
| **security_monitoring.sh** | Installs security tools (CSF, Fail2Ban) & monitoring tools (Zabbix, Prometheus, Grafana) | Debian 12 / Ubuntu 22.04 |

---

## 🛠 Installation Guide
### 1️⃣ Clone the Repository
```bash
git clone https://github.com/sumit-kumawat/whm.git
cd whm
```

### 2️⃣ Run the Desired Script
**Make the script executable:**
```bash
chmod +x script-name.sh
```

**Execute the script as root:**
```bash
./script-name.sh
```

---

## 📜 Script Details
### 🔹 CyberPanel + FOSSBilling (`cyberpanel_fossbilling.sh`)
- Installs **CyberPanel** (accessible at `https://cpanel.conzex.com`)
- Deploys **FOSSBilling** for automated billing
- Configures **automatic backups (45-day retention)**
- Enables **UFW Firewall**

### 🔹 VPS Hosting with Proxmox VE (`vps_proxmox.sh`)
- Installs **Proxmox VE**
- Enables **Proxmox Cluster Services**
- Disables **IPv6 for better compatibility**
- Opens firewall ports for **Proxmox Web UI**

### 🔹 Security & Monitoring (`security_monitoring.sh`)
- Installs **CSF Firewall & Fail2Ban** for security hardening
- Deploys **Zabbix, Prometheus, and Grafana** for monitoring
- Configures firewall rules for monitoring services

---

## 🎯 Contributing
Contributions are welcome! Feel free to submit **pull requests** for improvements or bug fixes.

---

## 📞 Support
For any queries, contact:
- 📧 Email: **support@conzex.com**

---

## 🏆 Credits
Maintained by **Conzex Global Private Limited** ([www.conzex.com](https://www.conzex.com))
