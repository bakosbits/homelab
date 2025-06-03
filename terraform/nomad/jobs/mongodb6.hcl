job "mongodb6" {
  datacenters = ["dc1"]
  type        = "service"

  group "mongodb6" {

    network {
      port "mongo" { static = "27017" }
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
        volumes = [
          "${job_volumes}/mongodb6/data/db:/data/db",
          "${job_volumes}/mongodb6/data/config:/data/config"
        ]
      }

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}