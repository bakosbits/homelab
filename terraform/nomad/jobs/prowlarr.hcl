job "prowlarr" {
  datacenters = ["dc1"]
  type        = "service"

  group "prowlarr" {

    network {
      port "http" { static = "9696" }
    }

    volume "prowlarr" {
      type            = "csi"
      read_only       = false
      source          = "prowlarr"
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
      name = "prowlarr"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.prowlarr.entrypoints=websecure",
        "traefik.http.routers.prowlarr.middlewares=auth"
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

      volume_mount {
        volume      = "prowlarr"
        destination = "/config"
      }

      volume_mount {
        volume      = "media"
        destination = "/data"
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