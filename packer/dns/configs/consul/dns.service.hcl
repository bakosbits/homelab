service {
  id      = "cluster-dns"
  name    = "cluster-dns"
  address = "{{GetInterfaceIP \"eth0\"}}"
  port    = 53
}