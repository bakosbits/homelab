job "grafana" {
  datacenters = ["dc1"]
  type        = "service"

  group "grafana" {

    network {
      port "http" { to = 3000 }
    }

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.rule=Host(`$${NOMAD_JOB_NAME}.${domain}`)",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.entrypoints=websecure",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.middlewares=auth"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "grafana" {
      driver = "docker"
      user   = "root"

      config {
        image = "grafana/grafana-oss:11.1.3"
        ports = ["http"]
        volumes = [
          "${job_volumes}/$${NOMAD_JOB_NAME}:/var/lib/grafana"
        ]

      }

      resources {
        cpu    = 200
        memory = 256
      }

      template {
        destination = "secrets/grafana.env"
        env         = true
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/grafana" }}
          {{- range .Tuples }}
            {{ .K }}={{ .V }}
          {{- end }}
        {{- end }}
        EOF
      }
    }
  }
}