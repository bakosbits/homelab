job "n8n" {
  datacenters = ["dc1"]
  type        = "service"

  group "n8n" {

    network {
      mode = "bridge"
      port "http" { 
        to = "5678" 
      }
    }

    service {
      name = "n8n"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.n8n.entrypoints=websecure",
        "traefik.http.routers.n8n.rule=Host(`n8n.bakos.me`)",
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
        PUID = 1000
        PGID = 1000        
        WEBHOOK_URL = "https://n8n.bakos.me/"
        N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
        N8N_LOG_LEVEL="debug"
        N8N_LOG_OUTPUT="file"
        N8N_LOG_FILE_PATH="/home/node/.n8n/n8n.log"
        N8N_SECURE_COOKIE=false
        TZ = "America/Denver"
      }


      resources {
        cpu    = 1024
        memory = 1024
      }
    }
  }
}