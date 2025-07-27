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
        "traefik.http.routers.n8n.rule=Host(`n8n.bakos.me`)",
        "traefik.http.routers.n8n.entrypoints=websecure",
        # "traefik.http.routers.n8n.middlewares=auth",
        # "traefik.http.routers.n8n.service=n8n",
        
        # "traefik.http.routers.n8n-webhook.entrypoints=websecure", 
        # "traefik.http.routers.n8n-webhook.rule=Host(`n8n.bakos.me`) && PathPrefix(`/webhook/`)",
        # "traefik.http.routers.n8n-webhook.service=n8n",
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
        image = "docker.n8n.io/n8nio/n8n:latest"
        ports = ["http"]
        volumes = [
          "/mnt/volumes/n8n:/home/node/.n8n"
        ]
      }

      env {
        WEBHOOK_URL = "https://n8n.bakos.me/"
        TZ = "America/Denver"
      }


      resources {
        cpu    = 1024
        memory = 1024
      }
    }
  }
}