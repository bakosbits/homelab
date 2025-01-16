job "loki" {
  datacenters = ["dc1"]
  type        = "service"

  group "loki" {

    network {
      port "http" { static = 3100 }
    }

    service {
      name = "loki"
      port = "http"

      check {
        port     = "http"
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "loki" {
      driver = "docker"
      user   = "root:root"

      config {
        image        = "grafana/loki:2.9.10"
        network_mode = "host"
        ports        = ["http"]
        args = [
          "-config.file",
          "local/loki/local-config.yaml",
        ]
        volumes = [
          "/mnt/volumes/loki:/loki"
        ]

      }

      resources {
        cpu    = 512
        memory = 256
      }

      template {
        destination = "local/loki/local-config.yaml"
        data        = <<-EOF
        {{- key "homelab/loki/loki.yaml"}}
        EOF
      }
    }
  }
}