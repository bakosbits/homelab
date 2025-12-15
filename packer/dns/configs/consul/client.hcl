server      = false
client_addr = "0.0.0.0"
bind_addr   = "{{GetInterfaceIP \"eth0\"}}"
data_dir    = "/opt/consul"
datacenter  = "dc1"
retry_join  = ["manager01.bakos.lan","manager02.bakos.lan", "manager03.bakos.lan"]
