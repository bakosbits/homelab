#!/usr/bin/bash

set -o errexit

DEBIAN_FRONTEND=noninteractive

# Install gnupg, ceph-common
sudo apt-get update && apt-get install -y gnupg ceph-common cloud-init

# Install Opensearch
wget https://packages.graylog2.org/repo/packages/graylog-6.1-repository_latest.deb
sudo dpkg -i graylog-6.1-repository_latest.deb
sudo apt-get update
sudo apt-get install -y graylog-datanode

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