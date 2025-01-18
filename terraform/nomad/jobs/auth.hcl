job "auth" {
  datacenters = ["dc1"]
  type        = "service"

  group "auth" {

    network {
      port "http" { static = "4181" }
    }

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.entrypoints=websecure",
        "traefik.http.middlewares.$${NOMAD_JOB_NAME}.forwardauth.address=http://$${NOMAD_JOB_NAME}.${consul_domain}:4181/",
        "traefik.http.middlewares.$${NOMAD_JOB_NAME}.forwardauth.trustForwardHeader=true",
        "traefik.http.middlewares.$${NOMAD_JOB_NAME}.forwardauth.authResponseHeaders=X-Forwarded-User",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.middlewares=$${NOMAD_JOB_NAME}",
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "auth" {
      driver = "docker"

      config {
        image        = "thomseddon/traefik-forward-auth:2.2.0"
        network_mode = "host"
        ports        = ["http"]
      }

      template {
        env         = true
        destination = "secrets/auth.env"
        data        = <<-EOF
          {{- with nomadVar "nomad/jobs/auth" }}
            {{- range .Tuples }}
              {{ .K }}={{ .V }}
            {{- end }}
          {{- end }}
        EOF
      }

      resources {
        cpu    = 200
        memory = 256
      }
    }
  }
}