job "sabnzbd" {
  datacenters = ["dc1"]
  type        = "service"

  group "sabnzbd" {

    network {
      port "http" { to = "8080" }
    }

    volume "sabnzbd" {
      type            = "csi"
      source          = "sabnzbd"
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
      port = "http"
      name = "sabnzbd"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.sabnzbd.entrypoints=websecure",
        "traefik.http.routers.sabnzbd.middlewares=auth"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "sabnzbd" {
      driver = "docker"

      config {
        image = "linuxserver/sabnzbd:4.3.2"
        ports = ["http"]
      }

      volume_mount {
        volume      = "sabnzbd"
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
        cpu    = 500
        memory = 512
      }
    }
  }
}
