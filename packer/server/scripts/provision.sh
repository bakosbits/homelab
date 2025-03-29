#!/usr/bin/bash

set -o errexit

DEBIAN_FRONTEND=noninteractive

# Add Docker's official GPG key:
sudo apt-get update
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repo to Apt sources:
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Add Hashicorp repo
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update

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