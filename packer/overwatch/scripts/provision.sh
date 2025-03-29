#!/usr/bin/bash

set -o errexit

DEBIAN_FRONTEND=noninteractive

# Install ceph, docker, nomad, consul, cloud-init
sudo apt-get update
sudo apt-get install -y ceph-common docker-ce consul nomad packer terraform ansible cloud-init cloud-utils


# Configure consul and nomad
sudo rm /etc/consul.d/* /etc/nomad.d/*
sudo systemctl disable consul nomad

# Configure ceph
sudo cp /tmp/configs/ceph/ceph.conf /etc/ceph/ceph.conf
sudo echo "192.168.1.10:/ /mnt ceph name=admin,secret=AQD1yylngu+3IxAAFKhcBp9ufX6sZNDkLJxyHw==,fs=cephfs,relatime,_netdev 0 0" >> /etc/fstab
sudo echo "192.168.1.10:/volumes/home/rab/ /home/rab ceph name=admin,secret=AQD1yylngu+3IxAAFKhcBp9ufX6sZNDkLJxyHw==,fs=cephfs,relatime,_netdev 0 0" >> /etc/fstab

# Disable root
sudo /usr/bin/passwd -l root
sudo sed -e 's/PermitRootLogin yes/#PermitRootLogin prohibit-password/' -i /etc/ssh/sshd_config

# Cleanup tmp
sudo find /tmp -type f -atime +10 -delete

# Finish
exit 0