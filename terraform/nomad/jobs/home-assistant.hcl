job "home-assistant" {
  datacenters = ["dc1"]
  type        = "service"

  group "home-assistant" {

    network {
      port "http" { static = "8123" }
    }

    volume "hass" {
      type            = "csi"
      read_only       = false
      source          = "hass"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    } 

    service {
      name = "home-assistant"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.home-assistant.entrypoints=websecure",
        "traefik.http.routers.home-assistant.rule=Host(`home-assistant.bakos.me`) || Host(`hass.bakos.me`)"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "home-assistant" {
      driver = "docker"

      config {
        image        = "homeassistant/home-assistant:2024.11.1"
        ports        = ["http"]
        network_mode = "host"
      }

      volume_mount {
        volume      = "hass"
        destination = "/config"
      }

      env {
        TZ = "America/Denver"
      }

      resources {
        cpu    = 1000
        memory = 1024
      }
    }
  }
}
