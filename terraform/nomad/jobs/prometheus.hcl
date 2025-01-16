job "prometheus" {
  datacenters = ["dc1"]
  type        = "service"

  group "prometheus" {

    network {
      port "http" { static = "9090" }
    }

    service {
      name = "prometheus"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.prometheus.entrypoints=websecure",
        "traefik.http.routers.prometheus.middlewares=auth"
      ]
      check {
        type     = "http"
        path     = "/-/healthy"
        name     = "http"
        interval = "5s"
        timeout  = "2s"
      }
    }

    task "prometheus" {
      driver = "docker"

      config {
        image        = "prometheus"
        network_mode = "host"
        ports        = ["http"]
        volumes = [
          "local/prometheus.yml:/etc/prometheus/prometheus.yml",
        ]
      }

      resources {
        cpu    = 1000
        memory = 512
      }

      template {
        destination   = "local/prometheus.yml"
        change_mode   = "signal"
        change_signal = "SIGHUP"
        data          = <<-EOF
        {{- key "homelab/prometheus"}}
        EOF
      }
    }
  }
}
