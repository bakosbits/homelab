.:53 {
  forward . 127.0.0.1:5353 ${nameserver}
  log
}

consul.:53 {
  errors
  forward . 127.0.0.1:8600
  log
}

${domain}.:53 {
  file /etc/coredns/zones/db.${domain} {
      reload 10s
  }
}