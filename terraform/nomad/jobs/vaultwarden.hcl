job "vaultwarden" {
  datacenters = ["dc1"]
  type        = "service"

  group "vaultwarden" {

    network {
      port "http" { to = 8089 }
    }

    service {
      name = "vaultwarden"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.vaultwarden.entrypoints=websecure",
        "traefik.http.routers.vaultwarden.middlewares=auth"
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
          "${job_volumes}/vaultwarden:/data"
        ]
      }

      resources {
        cpu    = 250
        memory = 250
      }
    }
  }
}