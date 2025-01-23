job "cannery" {
  datacenters = ["dc1"]
  type        = "service"

  group "cannery" {

    network {
      port "http" { static = "4000" }
    }

    volume "cannery" {
      type   = "host"
      source = "cannery"
    }

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "http"
      tags = [
        "traefik.enable=true",
<<<<<<< HEAD
        "traefik.http.routers.cannery.entrypoints=websecure",
        "traefik.http.routers.cannery.middlewares=forward-auth"
=======
        "traefik.http.routers."$${NOMAD_JOB_NAME}".entrypoints=websecure",
        "traefik.http.routers"$${NOMAD_JOB_NAME}".middlewares=auth"
>>>>>>> origin/main
      ]

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "cannery" {
      driver = "docker"

      config {
        image        = "shibaobun/cannery:latest"
        network_mode = "host"
        ports        = ["http"]
      }

      volume_mount {
        volume      = "cannery"
        destination = "/config"
      }

      resources {
        cpu    = 200
        memory = 256
      }

      template {
        env         = true
        destination = "secrets/env"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/cannery" }}
          {{- range .Tuples }}
            {{ .K }}={{ .V }}
          {{- end }}
        {{- end }}
        EOF        
      }
    }
  }
}
