job "mosquitto" {
  datacenters = ["dc1"]
  type        = "service"

  group "mosquitto" {

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
        image = "eclipse-mosquitto"
        ports = ["mqtt", "websocket"]
        volumes = [
          "local/mosquitto.conf:/mosquitto/config/mosquitto.conf",
          "secrets/password.txt:/mosquitto/config/password.txt",
          "/mnt/volumes/mosquitto/config:/mosquitto/config",
          "/mnt/volumes/mosquitto/data:/mosquitto/data",
          "/mnt/volumes/mosquitto/log:/mosquitto/log",
        ]
      }

      env {
        PUID = "1010"
        PGID = "1010"
        TZ   = "America/Denver"
      }

      resources {
        cpu    = 300
        memory = 384
      }


      template {
        destination = "local/mosquitto.conf"
        data        = <<-EOF
        {{- key "homelab/mqtt/mosquitto.conf" }}
        EOF
      }


      template {
        destination = "secrets/password.txt"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/mqtt" }}
          {{ .USER }}:{{ .PASSWORD }}
        {{- end }}        
        EOF
      }

    }
  }
}