job "influxdb" {
  datacenters = ["dc1"]
  type        = "service"

  group "influxdb" {

    network {
      port "http" { to = "8086" }
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
        volumes = [
          "/mnt/volumes/influxdb/config:/etc/influxdb2",
          "/mnt/volumes/influxdb/data:/var/lib/influxdb2"
        ]
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
