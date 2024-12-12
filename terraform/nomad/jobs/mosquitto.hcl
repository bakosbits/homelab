job "mosquitto" {
  datacenters = ["dc1"]
  type        = "service"

  group "moquitto" {

    network {
      port "mqtt" { static = 1883 }
      port "websocket" { static = 9001 }

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
          "/mnt/mosquitto/data:/mosquitto/data",
          "/mnt/mosquitto/config:/mosquitto/config",          
          "/mnt/mosquitto/log:/mosquitto/log",
          "local/mosquitto.conf:/mosquitto/config/mosquitto.conf",
          "local/password.txt:/mosquitto/config/password.txt",
        ]        
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