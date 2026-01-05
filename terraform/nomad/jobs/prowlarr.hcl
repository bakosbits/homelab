job "prowlarr" {
  datacenters = ["dc1"]
  type        = "service"

  group "prowlarr" {

    network {
      port "http" {
        to = 9696
      }
    }

    service {
      name = "prowlarr"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.prowlarr.entrypoints=websecure",
      ]

      check {
        type     = "http"
        path     = "/ping"
        interval = "10s"
        timeout  = "3s"
      }
    }

    task "prowlarr" {
      driver = "docker"
      config {
        image = "linuxserver/prowlarr:2.3.0"
        ports = ["http"]
        volumes = [
          "/mnt/volumes/prowlarr:/config",
          "/mnt/volumes/media:/data"
        ]
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