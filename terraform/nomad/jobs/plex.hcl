job "plex" {
  datacenters = ["dc1"]
  type        = "service"

  constraint {
    attribute = "$${attr.unique.hostname}"
    value     = "nomadcli02"
  }

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
        volumes = [
          "${job_volumes}/plex:/config",
          "${job_volumes}/media:/data"
        ]
      }

      env {
        PLEX_UID   = "1010"
        PLEX_GID   = "1010"
        PLEX_CLAIM = "claim-bCf7ssezRk2zmX_PDGyv"
      }

      resources {
        cpu    = 1000
        memory = 1000
      }
    }
  }
}