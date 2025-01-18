job "mongodb6" {
  datacenters = ["dc1"]
  type        = "service"

    constraint {
    attribute = "${attr.unique.hostname}"
    value     = "nomadcli01"
  }

  group "mongodb6" {

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

    volume "mongobd6" {
      type            = "csi"
      read_only       = false
      source          = "mongodb6"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }  

    service {
      name = "mongodb6"
      port = "mongo"
    }

    task "mongodb6" {
      driver = "docker"

      config {
        image        = "mongo:6.0.18"
        network_mode = "host"
        ports        = ["mongo"]      
      }

      volume_mount {
        volume      = "init-mongo"
        destination = "/docker-entrypoint-initdb.d/init-mongo.sh:ro"
      }

      volume_mount {
        volume      = "mongodb6"
        destination = "/data/db"
      }

      resources {
        cpu    = 512
        memory = 512
      }
    }
  }
}