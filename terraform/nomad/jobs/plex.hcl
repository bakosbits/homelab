job "plex" {
  datacenters = ["dc1"]
  type        = "service"

  group "plex" {

    network {
      port "http" { static = 32400 }
    }

    volume "plex" {
      type            = "csi"
      read_only       = false
      source          = "plex"
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
        read_only   = false
      }

      volume_mount {
        volume      = "media"
        destination = "/data"
      }

      env {
        PLEX_UID   = "1010"
        PLEX_GID   = "1010"
        PLEX_CLAIM = "claim-UfnzQyxu1GmSBGEwFW7W"
      }

      resources {
        cpu    = 1000
        memory = 1024
      }
    }
  }
}