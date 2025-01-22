job "vaultwarden" {
  datacenters = ["dc1"]
  type        = "service"

  group "vaultwarden" {

    network {
      port "http" { to = 8089 }
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
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "vaultwarden" {
      driver = "docker"

      env {
        ROCKET_PORT = 8089
      }

      config {
        image = "vaultwarden/server:1.31.0"
        ports = ["http"]
        volumes = [
          "${job_volumes}/$${NOMAD_JOB_NAME}:/data"
        ]
      }

      resources {
        cpu    = 250
        memory = 256
      }
    }
  }
}