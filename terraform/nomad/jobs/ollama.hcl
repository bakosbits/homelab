job "ollama" {
  datacenters = ["dc1"]
  type        = "service"

  group "ai" {

    network {
      port "http" { to = 8080 }
    }

    service {
      name = "ollama"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.open-webui.entrypoints=websecure",
        "traefik.http.routers.open-webui.middlewares=auth"
      ]
    }

    task "ollama" {
      driver = "docker"

      config {
        image = "ghcr.io/open-webui/open-webui:ollama"
        ports = ["http"]
        volumes = [
          "/mnt/volumes/open-webui:/app/backend/data",
          "/mnt/volumes/ollama:/root/.ollama"
        ]
      }

      resources {
        cpu    = 4000
        memory = 8192
      }
    }
  }
}