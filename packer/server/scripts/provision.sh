#!/usr/bin/bash

set -o errexit

DEBIAN_FRONTEND=noninteractive

# Install nomad, consul, cloud-init
sudo apt-get update
sudo apt-get install -y consul nomad cloud-init cloud-utils

# Configure consul and nomad
sudo rm /etc/consul.d/* /etc/nomad.d/*
sudo cp /tmp/configs/consul/server.hcl /etc/consul.d/consul.hcl
sudo cp /tmp/configs/nomad/server.hcl /etc/nomad.d/nomad.hcl
sudo systemctl enable consul nomad

# Disable root
sudo /usr/bin/passwd -l root
sudo sed -e 's/PermitRootLogin yes/#PermitRootLogin prohibit-password/' -i /etc/ssh/sshd_config

# Cleanup tmp
sudo find /tmp -type f -atime +10 -delete

# Finish
exit 0