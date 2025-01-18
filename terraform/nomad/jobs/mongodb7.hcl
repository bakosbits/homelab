job "mongodb7" {
  datacenters = ["dc1"]
  type        = "service"

  group "mongodb7" {

    network {
      port "mongo" { static = "27017" }
    }

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "mongo"
    }

    task "mongodb7" {
      driver = "docker"

      config {
        image        = "mongo:7.0.14"
        network_mode = "host"
        ports        = ["mongo"]
      }

      resources {
        cpu    = 500
        memory = 512
      }

      template {
        env         = true
        destination = "secrets/mongo.env"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/mongodb7" }}
          {{- range .Tuples }}
            {{ .K }}={{ .V }}
          {{- end }}
        {{- end }}
        EOF
      }
    }
  }
}