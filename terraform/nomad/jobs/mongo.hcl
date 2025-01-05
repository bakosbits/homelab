job "mongo" {
  datacenters = ["dc1"]
  type        = "service"

  group "mongo" {

    network {
      port "mongo" { static = "27017" }
    }

    volume "init_mongo" {
      type            = "csi"
      source          = "init_mongo"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }
    
    volume "mongo" {
      type            = "csi"
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
      }

      volume_mount {
        volume      = "init_mongo"
        destination = "/docker-entrypoint-initdb.d/init-mongo.sh"
        read_only   = true
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