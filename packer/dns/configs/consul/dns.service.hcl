service {
  id      = "coredns"
  name    = "coredns"
  address = "{{GetInterfaceIP \"eth0\"}}"
  port    = 53
}