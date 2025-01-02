server           = true
client_addr      = "0.0.0.0"
advertise_addr   = "{{GetInterfaceIP \"eth0\"}}"
bind_addr        = "{{GetInterfaceIP \"eth0\"}}"
bootstrap_expect = 3
data_dir         = "/opt/consul"
datacenter       = "dc1"
enable_syslog    = true
log_level        = "warn"
retry_join  = ["nomad-srv01.bakos.lan","nomad-srv02.bakos.lan", "nomad-srv03.bakos.lan"]
acl {
  enabled = true
}
ui_config {
  enabled = true
}
