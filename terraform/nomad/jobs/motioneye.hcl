job "motioneye" {
  datacenters = ["dc1"]
  type        = "service"

  group "motioneye" {

    network {
      port "http" { static = 8765 }
    }

    service {
      name = "motioneye"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.motioneye.entrypoints=websecure",
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "motioneye" {
      driver = "docker"

      config {
        image        = "ccrisan/motioneye:master-amd64"
        hostname     = "motioneye"
        privileged   = true
        ports        = ["http"]
        volumes = [
          "/etc/localtime:/etc/localtime:ro",
          "/mnt/volumes/motioneye/shared:/shared",
          "/mnt/volumes/motioneye/etc:/etc/motioneye"
        ]
      }

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}