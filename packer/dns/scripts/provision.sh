#!/usr/bin/bash
set -o errexit   # Stop on error
set -o nounset   # Stop if you use an undefined variable

export DEBIAN_FRONTEND=noninteractive

# Grab coredns
sudo wget https://github.com/coredns/coredns/releases/download/v1.11.3/coredns_1.11.3_linux_amd64.tgz -O /tmp/coredns.tgz

# Install consul
sudo apt-get update
sudo apt-get install -y consul

# Configure consul
sudo rm /etc/consul.d/*
sudo cp /tmp/configs/consul/client.hcl /etc/consul.d/consul.hcl
sudo cp /tmp/configs/consul/dns.service.hcl /etc/consul.d/dns.service.hcl
sudo systemctl disable consul

# Configure coredns
sudo tar -xvvf /tmp/coredns.tgz --directory /tmp
sudo chmod +x /tmp/coredns
sudo mv /tmp/coredns /usr/local/bin
sudo mkdir -p /opt/coredns /etc/coredns/zones
sudo useradd -d /var/lib/coredns -m coredns
sudo chown coredns:coredns /opt/coredns
sudo cp /tmp/configs/coredns/coredns.service /etc/systemd/system
sudo chmod 755 /etc/systemd/system/coredns.service

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