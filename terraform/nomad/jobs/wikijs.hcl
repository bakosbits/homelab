job "wikijs" {
  datacenters = ["dc1"]  
  type        = "service"

  group "wikijs" {

    network {
      port "http" { static = 3000 }
    }

    volume "wikijs" {
      type            = "csi"
      read_only       = false
      source          = "wikijs"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
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

    task "wikijs" {
      driver = "docker"

      config {
        image        = "linuxserver/wikijs:2.5.303"
        network_mode = "host"
        ports        = ["http"]
      }

      volume_mount {
        volume      = "wikijs"
        destination = "/config"
      }

      env {
        PUID = 1010
        PGID = 1010
        TZ   = "America/Denver"
      }

      resources {
        cpu    = 250
        memory = 256
      }
    }
  }
}