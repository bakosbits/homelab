job "influxdb" {
  datacenters = ["dc1"]
  type        = "service"

  group "influxdb" {

    network {
      port "http" { to = "8086" }
    }

    volume "influxdb_config" {
      type            = "csi"
      source          = "influxdb_config"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }

    volume "influxdb_data" {
      type            = "csi"
      source          = "influxdb_data"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }

    service {
      name = "influxdb"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.influxdb.entrypoints=websecure",
        "traefik.http.routers.influxdb.middlewares=auth"
      ]

      check {
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "1s"
      }
    }

    task "influxdb" {
      driver = "docker"

      config {
        image = "influxdb:2.7.8-alpine"
        ports = ["http"]
      }

      volume_mount {
        volume      = "influxdb_data"
        destination = "/var/lib/influxdb2"
      }

      volume_mount {
        volume      = "influxdb_config"
        destination = "/etc/influxdb2"
      }

      resources {
        cpu    = 500
        memory = 512
      }

      template {
        env         = true
        destination = "secrets/.env"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/influxdb" }}
          {{- range .Tuples }}
            {{ .K }}={{ .V }}
          {{- end }}
        {{- end }}        
        EOF
      }
    }
  }
}
