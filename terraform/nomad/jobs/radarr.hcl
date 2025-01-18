job "radarr" {
  datacenters = ["dc1"]
  type        = "service"

  group "radarr" {

    network {
      port "http" { static = "7878" }
    }

    volume "radarr" {
      type            = "csi"
      read_only       = false
      source          = "radarr"
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
      name = "$${NOMAD_JOB_NAME}"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.entrypoints=websecure",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.middlewares=auth"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "radarr" {
      driver = "docker"

      config {
        image        = "linuxserver/radarr:5.14.0"
        ports        = ["http"]
        network_mode = "host"
      }

      volume_mount {
        volume      = "radarr"
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