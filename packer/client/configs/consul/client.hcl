server      = false
client_addr = "0.0.0.0"
bind_addr   = "{{GetInterfaceIP \"eth0\"}}"
data_dir    = "/opt/consul"
datacenter  = "dc1"
retry_join  = ["nomadsrv01.bakos.lan","nomadsrv02.bakos.lan", "nomadsrv03.bakos.lan"]
