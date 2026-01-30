service {
  id      = "coredns"
  name    = "coredns"
  address = "{{ GetPrivateIP }}"
  port    = 53
}