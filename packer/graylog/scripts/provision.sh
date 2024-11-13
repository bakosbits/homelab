#!/usr/bin/bash

set -o errexit

DEBIAN_FRONTEND=noninteractive

# Install gnupg, ceph-common
sudo apt-get update && apt-get install -y gnupg ceph-common cloud-init

# Install libssl1.1
echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 871920D1991BC93C
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
sudo apt-get update
sudo apt-get install libssl1.1
sudo rm /etc/apt/sources.list.d/focal-security.list
sudo apt-key del 3B4FE6ACC0B21F32
sudo apt-key del 871920D1991BC93C

# Import MongoDB key and add repo
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] http://repo.mongodb.org/apt/debian bullseye/mongodb-org/7.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Install MongoDB
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo apt-mark hold mongodb-org

# Install Graylog
wget https://packages.graylog2.org/repo/packages/graylog-6.1-repository_latest.deb
sudo dpkg -i graylog-6.1-repository_latest.deb
sudo apt-get update
sudo apt-get install -y graylog-server 
sudo apt-mark hold graylog-server

# Setup ceph
sudo cp /tmp/configs/ceph/ceph.conf /etc/ceph/ceph.conf
sudo cp /tmp/configs/ceph/proxmox.secret /etc/ceph/proxmox.secret
sudo cp /tmp/configs/ceph/ceph.client.proxmox.keyring /etc/ceph/ceph.client.proxmox.keyring
sudo echo "192.168.1.10,192.168.1.11,192.168.1.12:/ /mnt ceph name=proxmox,secretfile=/etc/ceph/proxmox.secret,fs=cephfs,noatime,_netdev 0 0" >> /etc/fstab

# Disable root
sudo /usr/bin/passwd -l root
sudo sed -e 's/PermitRootLogin yes/#PermitRootLogin prohibit-password/' -i /etc/ssh/sshd_config

# Cleanup tmp
sudo find /tmp -type f -atime +10 -delete

# Load ceph kernel driver
sudo modprobe ceph

# Finish
exit 0