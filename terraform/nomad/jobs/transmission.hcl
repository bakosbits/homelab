job "transmission" {
  datacenters = ["dc1"]
  type        = "service"
  
  group "transmission" {

    network {
      port "http" { static = 9091 }
    }

    volume "transmission" {
      type            = "csi"
      source          = "transmission"
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
      name = "transmission"
      port = "http"
      tags = [
        "traefik.enable=true",       
        "traefik.http.routers.transmission.entrypoints=websecure",
        "traefik.http.routers.transmission.middlewares=auth"
      ]

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "transmission" {
      driver = "docker"

      config {
        image    = "lscr.io/linuxserver/transmission:latest"
        ports    = ["http"]
      }

      volume_mount {
        volume      = "transmission"
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
        memory = 768
      }
    }
  }
}