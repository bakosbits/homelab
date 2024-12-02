job "mosquitto" {
  datacenters = ["dc1"]
  type        = "service"

  group "moquitto" {

    network {
      port "mqtt" { static = 1883 }
      port "websocket" { static = 9001 }

    }

    volume "mosquitto-config" {
      type            = "csi"
      read_only       = false
      source          = "mosquitto-config"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }    

    volume "mosquitto-data" {
      type            = "csi"
      read_only       = false
      source          = "mosquitto-data"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }    

    volume "mosquitto-log" {
      type            = "csi"
      read_only       = false
      source          = "mosquitto-log"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }    

    service {
      name = "mosquitto"
      port = "mqtt"

      check {
        type     = "tcp"
        port     = "mqtt" 
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "mosquitto" {
      driver = "docker"

      config {
        image        = "eclipse-mosquitto"
        ports        = ["mqtt", "websocket"]
        network_mode = "host"
        volumes = [
          "local/mosquitto.conf:/mosquitto/config/mosquitto.conf",
          "local/password.txt:/mosquitto/config/password.txt",          
        ]        
      }

      volume_mount {
        volume      = "mosquitto-config"
        destination = "/mosquitto/config"
        read_only   = false
      }

      volume_mount {
        volume      = "mosquitto-data"
        destination = "/mosquitto/data"
        read_only   = false
      }

      volume_mount {
        volume      = "mosquitto-log"
        destination = "/mosquitto/log"
        read_only   = false
      }

      env {
        PUID = "1010"
        PGID = "1010"
        TZ   = "America/Denver" 
      }

      resources {
        cpu    = 300
        memory = 256
      }


      template {
        destination = "local/mosquitto.conf"
        data        = <<-EOF
        {{- key "homelab/mosquitto/mosquitto.conf" }}
        EOF
      }      

      template {
        destination = "local/password.txt"
        data        = <<-EOF
        {{- key "homelab/mosquitto/password.txt" }}
        EOF
      }      

    }
  }
}