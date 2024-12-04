job "matter" {
  datacenters = ["dc1"]
  type        = "service"

  group "matter" {

    network {
      port "websocket" { static = 5580 }

    }

    volume "matter" {
      type            = "csi"
      read_only       = false
      source          = "matter"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }    

    service {
      name = "matter"
      port = "websocket"

      check {
        type     = "tcp"
        port     = "websocket" 
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "matter" {
      driver = "docker"

      config {
        image        = "ghcr.io/home-assistant-libs/python-matter-server:stable"
        ports        = ["websocket"]
        network_mode = "host"       
      }

      volume_mount {
        volume      = "matter"
        destination = "/data"
        read_only   = false
      }

      resources {
        cpu    = 300
        memory = 256
      }    
    }
  }
}