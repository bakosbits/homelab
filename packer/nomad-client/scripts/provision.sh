#!/usr/bin/bash

set -o errexit

DEBIAN_FRONTEND=noninteractive

# Remove old Docker
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add docker repo to Apt sources:
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Add hashicorp repo
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update

# Install ceph, docker, nomad, consul, cloud-init
sudo apt-get update && apt-get install -y ceph-common docker-ce consul nomad cloud-init

# Setup registry proxy
sudo cp /tmp/configs/docker/daemon.json /etc/docker/daemon.json

# Configure consul and nomad
sudo rm /etc/consul.d/* /etc/nomad.d/*
sudo cp /tmp/configs/consul/client.hcl /etc/consul.d/consul.hcl
sudo cp /tmp/configs/nomad/client.hcl /etc/nomad.d/nomad.hcl
sudo systemctl enable consul nomad

# Setup ceph
sudo cp /tmp/configs/ceph/ceph.conf /etc/ceph/ceph.conf
sudo cp /tmp/configs/ceph/proxmox.secret /etc/ceph/proxmox.secret
sudo cp /tmp/configs/ceph/ceph.client.proxmox.keyring /etc/ceph/ceph.client.proxmox.keyring
sudo echo "192.168.1.10,192.168.1.11,192.168.1.12:/ /mnt ceph name=proxmox,secretfile=/etc/ceph/proxmox.secret,fs=cephfs,noatime,_netdev 0 0" >> /etc/fstab

# Add a media user
sudo /sbin/groupadd -g 1010 media
sudo /sbin/useradd -M -u 1010 -g 1010 media
sudo /sbin/usermod -L media

# Disable root
sudo /usr/bin/passwd -l root
sudo sed -e 's/PermitRootLogin yes/#PermitRootLogin prohibit-password/' -i /etc/ssh/sshd_config

# Cleanup tmp
sudo find /tmp -type f -atime +10 -delete

# Finish
exit 0