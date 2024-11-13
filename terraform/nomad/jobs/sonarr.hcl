job "sonarr" {
  datacenters = ["dc1"]
  type        = "service"

  group "sonarr" {

    network {
      port "http" { static = "8989" }
    }

    volume "sonarr" {
      type            = "csi"
      read_only       = false
      source          = "sonarr"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    } 

    volume "media" {
      type            = "csi"
      read_only       = false
      source          = "media"
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"
    }

    service {
      name = "sonarr"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.sonarr.entrypoints=websecure",
        "traefik.http.routers.sonarr.middlewares=auth"
      ]

      check {
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "sonarr" {
      driver = "docker"

      config {
        image        = "linuxserver/sonarr:4.0.9"
        ports        = ["http"]
        network_mode = "host"
      }

      volume_mount {
        volume      = "sonarr"
        destination = "/config"
      }

      volume_mount {
        volume      = "media"
        destination = "/data"
      }

      env {
        PUID = 1010
        PGID = 1010
        TZ   = "America/Denver"
      }

      resources {
        cpu    = 1000
        memory = 1024
      }
    }
  }
}