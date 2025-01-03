job "mongo" {
  datacenters = ["dc1"]
  type        = "service"

  group "mongo" {

    network {
      port "mongo" { static = "27017" }
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
        volumes = [
          "/local/init-mongo.sh:/docker-entrypoint-initdb.d/init-mongo.sh:ro"
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
        destination = "local/init-mongo.sh"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/mongo" }}
          #!/bin/bash

          if which mongosh > /dev/null 2>&1; then
            mongo_init_bin='mongosh'
          else
            mongo_init_bin='mongo'
          fi
          "${mongo_init_bin}" 
          use {{ .MONGO_AUTHSOURCE }}
          db.auth("{{ .MONGO_INITDB_ROOT_USERNAME }}, "{{ .MONGO_INITDB_ROOT_PASSWORD }})
          db.createUser({
            user: "{{ .MONGO_USER }},
            pwd: "{{ .MONGO_PASS }},
            roles: [
              { db: "{{ .MONGO_DBNAME }}", role: "dbOwner" },
              { db: "{{ .MONGO_DBNAME }}_stat", role: "dbOwner" }
            ]
          })
        {{- end }}
        EOF
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