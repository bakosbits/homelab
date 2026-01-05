#!/usr/bin/bash

set -o errexit

DEBIAN_FRONTEND=noninteractive

# Install ceph, docker, nomad, consul, cloud-init
sudo apt-get update
sudo apt-get install -y ceph-common docker-ce consul nomad cloud-init cloud-utils resolvconf

# Configure docker and registry proxy
sudo cp /tmp/configs/docker/daemon.json /etc/docker/daemon.json

# Configure consul and nomad
sudo rm /etc/consul.d/* /etc/nomad.d/*
sudo cp /tmp/configs/consul/client.hcl /etc/consul.d/consul.hcl
sudo cp /tmp/configs/nomad/client.hcl /etc/nomad.d/nomad.hcl
sudo systemctl enable consul nomad

# Configure ceph
sudo cp /tmp/configs/ceph/ceph.conf /etc/ceph/ceph.conf
sudo cp /tmp/configs/ceph/ceph.client.admin.keyring /etc/ceph/ceph.client.admin.keyring
sudo echo "192.168.1.10,192.168.1.11,192.168.1.12:/ /mnt ceph name=admin,secret=AQD1yylngu+3IxAAFKhcBp9ufX6sZNDkLJxyHw==,fs=cephfs,relatime,_netdev 0 0" >> /etc/fstab

# Configure revolv.conf
echo 'nameserver 192.168.2.1' | sudo tee -a /etc/resolvconf/resolv.conf.d/head > /dev/null

# Add a containers user
sudo /sbin/groupadd -g 1000 containers
sudo /sbin/useradd -M -u 1000 -g 1000 containers
sudo /sbin/usermod -L containers

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