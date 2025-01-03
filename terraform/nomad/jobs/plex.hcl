job "plex" {
  datacenters = ["dc1"]
  type        = "service"

  constraint {
    attribute = "$${attr.unique.hostname}"
    value     = "nomad-cli03"
  }

  group "plex" {

    network {
      port "http" { static = 32400 }
    }

    volume "plex" {
      type            = "csi"
      source          = "plex"
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
      name = "plex"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.plex.entrypoints=websecure",
        "traefik.http.routers.plex.middlewares=auth"
      ]

      check {
        type     = "http"
        path     = "/web"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "plex" {
      driver = "docker"

      config {
        image        = "plexinc/pms-docker:latest"
        ports        = ["http"]
        network_mode = "host"
      }

      volume_mount {
        volume      = "plex"
        destination = "/config"
      }

      volume_mount {
        volume      = "media"
        destination = "/data"
      }

      env {
        PLEX_UID   = "1010"
        PLEX_GID   = "1010"
        PLEX_CLAIM = "claim-g8FqEYEXdk_MTxgTi9Z-"
      }

      resources {
        cpu    = 1000
        memory = 1024
      }
    }
  }
}