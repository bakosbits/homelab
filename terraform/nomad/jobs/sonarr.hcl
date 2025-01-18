job "sonarr" {
  datacenters = ["dc1"]
  type        = "service"

  group "sonarr" {

    network {
      port "http" { static = "8989" }
    }

    service {
      name = "sonarr"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.sonarr.entrypoints=websecure",
        "traefik.http.routers.sonarr.middlewares=auth"
      ]

      check {
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "sonarr" {
      driver = "docker"

      config {
        image = "linuxserver/sonarr:4.0.9"
        ports = ["http"]
        volumes = [
          "${job_volumes}/sonarr:/config",
          "${job_volumes}/media:/data"
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