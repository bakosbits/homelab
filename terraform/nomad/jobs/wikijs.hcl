job "wikijs" {
  datacenters = ["dc1"]

  group "wikijs" {

    network {
      port "http" { to = 3000 }
    }

    service {
      name = "wikijs"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.wikijs.entrypoints=websecure",
        "traefik.http.routers.wikijs.middlewares=auth"
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
        image = "linuxserver/wikijs:2.5.303"
        ports = ["http"]
        volumes = [
          "/mnt/volumes/wikijs:/config"
        ]
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