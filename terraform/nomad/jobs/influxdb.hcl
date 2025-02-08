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
        volumes = [
          "${job_volumes}/influxdb/config:/etc/influxdb2",
          "${job_volumes}/influxdb/data:/var/lib/influxdb2"
        ]
      }

      resources {
        cpu    = 500
        memory = 500
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
