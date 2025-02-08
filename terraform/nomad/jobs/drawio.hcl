job "drawio" {
  datacenters = ["dc1"]
  type        = "service"

  group "drawio" {

    network {
      port "http" { to = 8080 }
    }

    service {
      name = "draw-io"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.draw-io.entrypoints=websecure",
        "traefik.http.routers.draw-io.middlewares=auth"
      ]

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "drawio" {
      driver = "docker"

      config {
        image = "jgraph/drawio:24.7.5"
        ports = ["http"]
      }

      resources {
        cpu    = 500
        memory = 500
      }
    }
  }
}
