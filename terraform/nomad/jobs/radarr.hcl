job "radarr" {
  datacenters = ["dc1"]
  type        = "service"

  group "radarr" {

    network {
      port "http" { static = "7878" }
    }

    service {
      name = "radarr"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.radarr.entrypoints=websecure",
        "traefik.http.routers.radarr.middlewares=auth"
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
        volumes = [
          "/mnt/volumes/radarr:/config",
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