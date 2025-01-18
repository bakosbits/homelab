job "unifi" {
  datacenters = ["dc1"]
  type        = "service"

  constraint {
    attribute = "$${attr.unique.hostname}"
    value     = "nomadcli03"
  }

  group "unifi" {

    network {
      port "http" { static = "8443" }
    }

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.entrypoints=websecure",
        "traefik.http.services.$${NOMAD_JOB_NAME}.loadbalancer.server.scheme=https",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.middlewares=auth"
      ]

      check {
        type     = "tcp"
        path     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "unifi" {
      driver = "docker"

      config {
        image        = "linuxserver/unifi-network-application:8.6.9"
        network_mode = "host"
        ports        = ["http"]
        volumes      = [
          "${job_volumes}/$${NOMAD_JOB_NAME}:/config"
        ]
      }

      resources {
        cpu    = 1000
        memory = 1536
      }

      template {
        env         = true
        destination = "secrets/unifi.env"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/$${NOMAD_JOB_NAME}" }}
          {{- range .Tuples }}
            {{ .K }}={{ .V }}
          {{- end }}
        {{- end }}
        EOF
      }
    }
  }
}