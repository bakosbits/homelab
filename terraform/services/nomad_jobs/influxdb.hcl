job "influxdb" {
  datacenters = ["dc1"]
  type        = "service"

  group "influxdb" {

    network {
      port "http" { to = "8086" }
    }

    volume "influxdb-config" {
      type            = "csi"
      source          = "influxdb-config"
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"      
    }

    volume "influxdb-data" {
      type            = "csi"
      source          = "influxdb-data"
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"      
    }

    service {
      name = "influxdb"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.influxdb.entrypoints=websecure",
      ]

      check {
        type     = "http"
        path     = "/health"
        interval = "10s"
        timeout  = "3s"
      }
    }

    task "influxdb" {
      driver = "docker"

      config {
        image = "influxdb:2.7.8-alpine"
        ports = ["http"]
      }

      volume_mount {
        volume      = "influxdb-config"
        destination = "/etc/influxdb2"
      }

      volume_mount {
        volume      = "influxdb-data"
        destination = "/var/lib/influxdb2"
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
