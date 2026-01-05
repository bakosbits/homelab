job "sonarr" {
  datacenters = ["dc1"]
  type        = "service"

  group "sonarr" {

    network {
      port "http" {
        to = 8989
      }
    }

    service {
      name = "sonarr"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.sonarr.entrypoints=websecure",
      ]

      check {
        type     = "http"
        path     = "/ping"
        interval = "10s"
        timeout  = "3s"
      }
    }

    task "sonarr" {
      driver = "docker"

      config {
        image = "linuxserver/sonarr:4.0.14"
        ports = ["http"]
        volumes = [
          "/mnt/volumes/sonarr:/config",
          "/mnt/volumes/media:/data"
        ]
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