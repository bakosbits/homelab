job "emulatorjs" {
  datacenters = ["dc1"]
  type        = "service"

  group "emulatorjs" {

    network {
      port "http" {
        to = 80
      }

      port "admin" {
        to = 3000
      }
    }

    volume "arcade_config" {
      type            = "csi"
      read_only       = false
      source          = "arcade_config"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }  

    volume "arcade_data" {
      type            = "csi"
      read_only       = false
      source          = "arcade_data"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    } 
    
    service {
      name = "arcade"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.arcade.entrypoints=websecure",
        "traefik.http.routers.arcade.middlewares=auth"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    service {
      name = "arcade-admin"
      port = "admin"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.arcade-admin.entrypoints=websecure",
        "traefik.http.routers.arcade-admin.middlewares=auth"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "emulatorjs" {
      driver = "docker"

      config {
        image        = "linuxserver/emulatorjs:latest"
        network_mode = "bridge"
        ports        = ["http", "admin"]
      }

      volume_mount {
        volume      = "arcade_config"
        destination = "/config"
      }

      volume_mount {
        volume      = "arcade_data"
        destination = "/data"
      }

      env {
        PUID = "1000"
        PGID = "1000"
        TZ   = "America/Denver"
      }

      resources {
        memory_max = 2048
      }
    }
  }
}