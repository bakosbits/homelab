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
        "traefik.http.routers.vaultwarden.middlewares=auth@consulcatalog"
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
      force_pull   = false

      config {
        image = "vaultwarden/server:1.31.0"

        ports = ["http"]
        volumes = [
          "/mnt/volumes/vaultwarden:/data"
        ]
      }

      env {
        ROCKET_PORT = 8089
      }

      resources {
        cpu    = 250
        memory = 256
      }
    }
  }
}