set -o errexit

DEBIAN_FRONTEND=noninteractive

# Grab coredns
sudo wget https://github.com/coredns/coredns/releases/download/v1.11.3/coredns_1.11.3_linux_amd64.tgz -O /tmp/coredns.tgz

# Install consul resolvconf cloud-init
sudo apt-get update
sudo apt-get install -y consul resolvconf cloud-init cloud-utils

# Configure consul
sudo rm /etc/consul.d/*
sudo cp /tmp/configs/consul/client.hcl /etc/consul.d/consul.hcl
sudo cp /tmp/configs/consul/dns.service.hcl /etc/consul.d/dns.service.hcl
sudo systemctl enable consul

# Configure resolvconf
echo 'nameserver 127.0.0.1' | sudo tee -a /etc/resolvconf/resolv.conf.d/head > /dev/null

# Configure coredns
sudo tar -xvvf /tmp/coredns.tgz --directory /tmp
sudo chmod +x /tmp/coredns
sudo mv /tmp/coredns /usr/local/bin
sudo mkdir -p /opt/coredns /etc/coredns/zones
sudo useradd -d /var/lib/coredns -m coredns
sudo chown coredns:coredns /opt/coredns
sudo cp /tmp/configs/coredns/corefile /etc/coredns/corefile
sudo cp /tmp/configs/coredns/db.bakos.me /etc/coredns/zones/db.bakos.me
sudo cp /tmp/configs/coredns/coredns.service /etc/systemd/system
sudo chmod 755 /etc/systemd/system/coredns.service
sudo systemctl enable coredns

# Disable root
sudo /usr/bin/passwd -l root
sudo sed -e 's/PermitRootLogin yes/#PermitRootLogin prohibit-password/' -i /etc/ssh/sshd_config

# Cleanup tmp
sudo find /tmp -type f -atime +10 -delete

# Finish
exit 0