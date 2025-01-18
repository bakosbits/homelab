job "grafana" {
  datacenters = ["dc1"]
  type        = "service"

  group "grafana" {

    network {
      port "http" {
        to = 3000
      }
    }

    volume "grafana" {
      type            = "csi"
      read_only       = false
      source          = "grafana"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
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
        image        = "grafana/grafana-oss:11.1.3"
        network_mode = "bridge"
        ports        = ["http"]
      }

      volume_mount {
        volume      = "grafana"
        destination = "/var/lib/grafana"
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