job "mongodb7" {
  datacenters = ["dc1"]
  type        = "service"

  group "mongodb7" {

    network {
      port "mongo" { static = "27017" }
    }

    service {
      name = "mongodb7"
      port = "mongo"
    }

    task "mongodb7" {
      driver = "docker"

      config {
        image        = "mongo:7.0.14"
        network_mode = "host"
        ports        = ["mongo"]
        volumes = [
          "/mnt/volumes/init_mongo/init-mongo.sh:/docker-entrypoint-initdb.d/init-mongo.sh:ro",
          "/mnt/volumes/mongodb7:/data/db"
        ]
      }

      resources {
        cpu    = 500
        memory = 512
      }

      template {
        env         = true
        destination = "secrets/mongo.env"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/mongo" }}
          {{- range .Tuples }}
            {{ .K }}={{ .V }}
          {{- end }}
        {{- end }}
        EOF
      }
    }
  }
}