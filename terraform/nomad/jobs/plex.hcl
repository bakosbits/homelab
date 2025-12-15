job "plex" {
  datacenters = ["dc1"]
  type        = "service"

  group "plex" {

    network {
      port "http" { static = 32400 }
    }

    service {
      name = "plex"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.plex.entrypoints=websecure",     
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
        image      = "plexinc/pms-docker:latest"   
        network_mode = "host"
        ports      = ["http"]
        volumes = [
          "/mnt/volumes/plex:/config",
          "/mnt/volumes/media:/data"
        ]        
      }

      env {
        PLEX_UID   = "1010"
        PLEX_GID   = "1010"
        PLEX_CLAIM = "claim-NCxXrMeNC7yJD57cnVcu"
      }

      resources {
        cpu    = 1000
        memory = 1024
      }
    }
  }
}