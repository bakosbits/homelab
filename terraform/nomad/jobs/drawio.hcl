job "drawio" {
  datacenters = ["dc1"]
  type        = "service"

  group "drawio" {

    network {
      port "http" { to = 8080 }
    }

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.entrypoints=websecure",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.middlewares=auth"
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
        memory = 512
      }
    }
  }
}
