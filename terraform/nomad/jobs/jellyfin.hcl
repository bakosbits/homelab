job "jellyfin" {
  datacenters = ["dc1"]
  type        = "service"

  group "jellyfin" {

    network {
      port "http" { static = 8096 }
    }

    volume "jellyfin" {
      type            = "csi"
      source          = "jellyfin"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }

    volume "media" {
      type            = "csi"
      source          = "media"
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"
    }

    service {
      name = "jellyfin"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.jellyfin.entrypoints=websecure",
        "traefik.http.routers.jellyfin.middlewares=auth"
      ]

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "jellyfin" {
      driver = "docker"

      config {
        image = "linuxserver/jellyfin:10.9.8"
        ports = ["http"]
      }

      volume_mount {
        volume      = "jellyfin"
        destination = "/config/cache"
      }

      volume_mount {
        volume      = "media"
        destination = "/data"
      }

      env {
        PUID                        = "1010"
        PGID                        = "1010"
        JELLYFIN_PublishedServerUrl = "https://jellyfin.bakos.me"
      }

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}