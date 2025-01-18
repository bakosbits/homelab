job "pgweb" {
  datacenters = ["dc1"]
  type        = "service"

  group "pgweb" {

    network {
      port "http" { static = 8082 }
    }

    service {
      name = "pgweb"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.pgweb.entrypoints=websecure",
        "traefik.http.routers.pgweb.middlewares=auth"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "pgweb" {
      driver = "docker"

      config {
        image        = "sosedoff/pgweb:0.15.0"
        network_mode = "host"
        ports        = ["http"]
        command      = "/usr/bin/pgweb"
        args         = ["--bind=0.0.0.0", "--listen=8082"]
      }

      resources {
        cpu    = 128
        memory = 128
      }
    }
  }
}