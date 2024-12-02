job "mongo" {
  datacenters = ["dc1"]
  type        = "service"

  group "mongo" {

    network {
      port "mongo" { static = "27017" }
    }


    volume "mongo" {
      type            = "csi"
      read_only       = false
      source          = "mongo"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }  

    service {
      name = "mongo"
      port = "mongo"
    }

    task "mongo" {
      driver = "docker"

      config {
        image        = "mongo:7.0.14"
        network_mode = "host"
        ports        = ["mongo"]
        volumes = [
          "/mnt/volumes/init_mongo/init-mongo.sh:/docker-entrypoint-initdb.d/init-mongo.sh:ro"
        ]
      }

      volume_mount {
        volume      = "mongo"
        destination = "/data/db"
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