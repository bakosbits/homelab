job "n8n" {
  datacenters = ["dc1"]
  type        = "service"

  group "n8n" {

    network {
      port "http" { to = "5678" }
    }

    service {
      name = "n8n"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.n8n.entrypoints=websecure",
        "traefik.http.routers.n8n.middlewares=auth"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "n8n" {
      driver = "docker"

      config {
        image = "docker.n8n.io/n8nio/n8n"
        ports = ["http"]
        volumes = [
          "${job_volumes}/n8n:/n8nio/n8n"
        ]
      }

      env {
        TZ = "America/Denver"
      }


      resources {
        cpu    = 750
        memory = 768
      }
    }
  }
}