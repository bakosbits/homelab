job "mongodb7" {
  datacenters = ["dc1"]
  type        = "service"

  group "mongodb7" {

    network {
      port "mongo" { static = "27017" }
    }

    volume "init-mongo" {
      type            = "csi"
      read_only       = true
      source          = "init-mongo"
      attachment_mode = "file-system"
      access_mode     = "multi-node-reader-only"
    } 

    volume "mongobd7" {
      type            = "csi"
      read_only       = false
      source          = "mongodb7"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
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

      volume_mount {
        volume      = "init-mongo"
        destination = "/docker-entrypoint-initdb.d/init-mongo.sh:ro"
      }

      volume_mount {
        volume      = "mongodb7"
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