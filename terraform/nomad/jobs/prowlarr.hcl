job "prowlarr" {
  datacenters = ["dc1"]
  type        = "service"

  group "prowlarr" {

    network {
      port "http" { static = "9696" }
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

    task "prowlarr" {
      driver = "docker"

      config {
        image        = "linuxserver/prowlarr:1.25.4"
        ports        = ["http"]
        network_mode = "host"
      }

      env {
        PUID = 1010
        PGID = 1010
      }

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}