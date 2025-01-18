job "mosquitto" {
  datacenters = ["dc1"]
  type        = "service"

  group "moquitto" {

    network {
      port "mqtt" { static = 1883 }
      port "websocket" { static = 9001 }

    }

    service {
      name = "$${NOMAD_JOB_NAME}"
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
          "${job_volumes}/mosquitto/config:/mosquitto/config",
          "${job_volumes}/mosquitto/data:/mosquitto/data",
          "${job_volumes}/mosquitto/log:/mosquitto/log",
          "local/mosquitto.conf:/mosquitto/config/mosquitto.conf",
          "secrets/password.txt:/mosquitto/config/password.txt",
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