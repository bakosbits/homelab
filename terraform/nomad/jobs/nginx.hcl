job "nginx" {
  datacenters = ["dc1"]
  type        = "service"

  group "nginx" {

    network {
      port "http" { static = 8182 }
    }

    service {
      name = "nginx"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.nginx.entrypoints=websecure",
      ]

    }

    task "nginx" {
      driver = "docker"

      config {
        image        = "linuxserver/nginx:latest"
        ports        = ["http"]
        network_mode = "host"
        volumes = [
          "/mnt/volumes/nginx/config:/config",          
        ]
      }

      env {
        PUID   = "1010"
        PGID   = "1010"
        TZ     = "Etc/UTC"
      }

      resources {
        cpu    = 200
        memory = 256
      }
    }
  }
}