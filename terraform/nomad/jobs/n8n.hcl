job "n8n" {
  datacenters = ["dc1"]
  type        = "service"

  group "n8n" {

    network {
      port "http" { to = "5678" }
    }

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "http"
    }

    task "n8n" {
      driver = "docker"

      config {
        image        = "docker.n8n.io/n8nio/n8n"
        ports        = ["http"]      
      }

      env {
        TZ = "America/Denver"
      }
      
      resources {
        cpu    = 512
        memory = 512
      }
    }
  }
}