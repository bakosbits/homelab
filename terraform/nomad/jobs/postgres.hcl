job "postgres" {
  datacenters = ["dc1"]
  type        = "service"

  group "postgres" {

    network {
      port "postgres" { to = "5432" }
    }

    service {
      name = "postgres"
      port = "postgres"
      tags = [
        "traefik.enable=true",
        "traefik.tcp.routers.$${NOMAD_JOB_NAME}.entrypoints=postgres",
        "traefik.tcp.routers.$${NOMAD_JOB_NAME}.rule=HostSNI(`*`)",
        "traefik.tcp.services.$${NOMAD_JOB_NAME}.loadBalancer.server.port=$${NOMAD_HOST_PORT_postgres}"
      ]

      check {
        type     = "tcp"
        port     = "postgres"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "postgres" {
      driver = "docker"

      config {
        image = "postgres:16.4"
        ports = ["postgres"]
        volumes = [
          "${job_volumes}/postgres:/var/lib/pgsql/db"
        ]
      }

      resources {
        cpu    = 1000
        memory = 1024
      }

      template {
        env         = true
        destination = "secrets/postgres.env"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/postgres" }}
          {{- range .Tuples }}
            {{ .K }}={{ .V }}
          {{- end }}
        {{- end }}
        EOF
      }
    }
  }
}
