#!/usr/bin/bash
set -o errexit   # Stop on error
set -o nounset   # Stop if you use an undefined variable

export DEBIAN_FRONTEND=noninteractive

# Install docker, nomad, consul
sudo apt-get update
sudo apt-get install -y docker-ce consul nomad

# Configure docker registry proxy
sudo cp /tmp/configs/docker/daemon.json /etc/docker/daemon.json

# Configure consul and nomad
sudo rm /etc/consul.d/* /etc/nomad.d/*
sudo systemctl disable consul nomad

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

# Enable cloud-init
sudo rm -f /etc/cloud/cloud-init.disabled

# Sanitize
sudo truncate -s 0 /etc/hostname
sudo truncate -s 0 /etc/machine-id
[ -f /var/lib/dbus/machine-id ] && sudo rm -f /var/lib/dbus/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id

# Cleanup tmp
sudo find /tmp -type f -atime +10 -delete

# Finish
exit 0