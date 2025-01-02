job "vaultwarden" {
  datacenters = ["dc1"]
  type        = "service"
  
  group "vaultwarden" {

    network {
      port "http" { to = 8089 }
    }

    volume "vaultwarden" {
      type            = "csi"
      source          = "vaultwarden"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
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
        image   = "vaultwarden/server:1.31.0"
        ports   = ["http"]
      }

      volume_mount {
        volume      = "vaultwarden"
        destination = "/data"
      }

      resources {
        cpu    = 250
        memory = 256
      }
    }
  }
}