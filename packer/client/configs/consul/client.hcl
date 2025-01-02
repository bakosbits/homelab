server      = false
client_addr = "0.0.0.0"
bind_addr   = "{{GetInterfaceIP \"eth0\"}}"
data_dir    = "/opt/consul"
datacenter  = "dc1"
retry_join  = ["nomad-srv01.bakos.lan","nomad-srv02.bakos.lan", "nomad-srv03.bakos.lan"]
