job "prometheus" {
  datacenters = ["dc1"]
  type        = "service"

  group "prometheus" {

    network {
      port "http" { static = "9090" }
    }

    volume "prometheus" {
      type            = "csi"
      read_only       = false
      source          = "prometheus"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    } 

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.entrypoints=websecure",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.middlewares=auth"
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
          "/mnt/volumes/prometheus:/opt/prometheus",
          "local/prometheus.yml:/etc/prometheus/prometheus.yml",
        ]
      }

      volume_mount {
        volume      = "postgres"
        destination = "/opt/prometheus"
      }

      template {
        destination   = "local/prometheus.yml"
        change_mode   = "signal"
        change_signal = "SIGHUP"
        data          = <<-EOF
        {{- key "homelab/coredns/prometheus"}}
        EOF
      }

      resources {
        cpu    = 1000
        memory = 512
      }
    }
  }
}
