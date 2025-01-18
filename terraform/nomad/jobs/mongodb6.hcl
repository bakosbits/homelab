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

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "mongo"
    }

    task "mongodb6" {
      driver = "docker"

      config {
        image        = "mongo:6.0.18"
        network_mode = "host"
        ports        = ["mongo"]      
        volumes = [
          "${job_volumes}/$${NOMAD_JOB_NAME}/data/db:/data/db",
          "${job_volumes}/$${NOMAD_JOB_NAME}/data/config:/data/config"          
        ]
      }

      resources {
        cpu    = 512
        memory = 512
      }
    }
  }
}