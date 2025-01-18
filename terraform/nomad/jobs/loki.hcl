job "loki" {
  datacenters = ["dc1"]
  type        = "service"

  group "loki" {

    network {
      port "http" { static = 3100 }
    }

    volume "loki" {
      type            = "csi"
      read_only       = false
      source          = "loki"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
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
      }

      volume_mount {
        volume      = "loki"
        destination = "/loki"
      }

      template {
        destination = "local/loki/local-config.yaml"
        data        = <<-EOF
        {{- key "homelab/loki/loki.yaml"}}
        EOF
      }

      resources {
        cpu    = 512
        memory = 256
      }
    }
  }
}