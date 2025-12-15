job "windmill" {
  datacenters = ["dc1"]
  type        = "service"

  group "windmill" {

    network {
      port "http" { static = "8000" }
      port "smtp" { static = "2525" }
    }

    service {
      name = "windmill"
      port = "http"
      tags = [
         // --- Router for Windmill UI (with authentication) ---
          "traefik.enable=true", // Enable Traefik for this service
          "traefik.http.routers.windmill-ui.entrypoints=websecure", // Use HTTPS entrypoint
          "traefik.http.routers.windmill-ui.rule=Host(`windmill.bakos.me`)", // Route based on hostname
          "traefik.http.routers.windmill-ui.middlewares=auth@consulcatalog", // Apply your authentication middleware
          "traefik.http.routers.windmill-ui.service=windmill", // Link to this service

          // --- Router for Windmill Webhooks (NO authentication) ---
          "traefik.http.routers.windmill-webhook.entrypoints=websecure", // Use HTTPS entrypoint
          // Rule to match your hostname AND the specific API path prefix for webhooks
          "traefik.http.routers.windmill-webhook.rule=Host(`windmill.bakos.me`) && PathPrefix(`/api/w`)",
          "traefik.http.routers.windmill-webhook.service=windmill", // Link to the same service
          // IMPORTANT: NO "traefik.http.routers.windmill-webhook.middlewares=auth@consulcatalog" here!

          // --- Service Definition (tells Traefik where to send traffic) ---
          "traefik.http.services.windmill.loadbalancer.server.port=8000" // The internal port of your Windmill app
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "windmill-server" {
      driver = "docker"

      config {
        image = "ghcr.io/windmill-labs/windmill:latest"
        ports = ["http", "smtp"]
        volumes = [
          "/mnt/volumes/windmill/logs:/tmp/windmill/logs",
          "/mnt/volumes/windmill/cache:/tmp/windmill/cache"
        ]
      }

      env {
        DATABASE_URL = "postgres://postgres:g14cla55ified@postgres.service.consul/windmill?sslmode=disable"
        MODE         = "server"
      }

      resources {
        cpu    = 512
        memory = 512
      }

      # template {
      #   env         = true
      #   destination = "secrets/windmill.env"
      #   data        = <<-EOF
      #   {{- with nomadVar "nomad/jobs/windmill" }}
      #     {{- range .Tuples }}
      #       {{ .K }}={{ .V }}
      #     {{- end }}
      #   {{- end }}
      #   EOF
      # }      
    }

    task "windmill-worker" {
      driver = "docker"

      config {
        image = "ghcr.io/windmill-labs/windmill:main"
        volumes = [
          "/mnt/volumes/windmill:/tmp/windmill"
        ]
      }

      env {
        DATABASE_URL = "postgres://postgres:g14cla55ified@postgres.service.consul/windmill?sslmode=disable"
        MODE         = "worker"
        WORKER_GROUP = "default"
      }

      resources {
        cpu    = 1024
        memory = 2048
      }

      # template {
      #   env         = true
      #   destination = "secrets/windmill.env"
      #   data        = <<-EOF
      #   {{- with nomadVar "nomad/jobs/windmill" }}
      #     {{- range .Tuples }}
      #       {{ .K }}={{ .V }}
      #     {{- end }}
      #   {{- end }}
      #   EOF
      # }      
    }    
  }
}