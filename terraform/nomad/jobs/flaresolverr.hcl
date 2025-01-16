job "flaresolverr" {
  datacenters = ["dc1"]
  type        = "service"

  group "flaresolverr" {

    network {
      port "http" { static = "8191" }
    }

    service {
      name = "flaresolverr"
      port = "http"

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "flaresolverr" {
      driver = "docker"

      config {
        image        = "flaresolverr/flaresolverr:latest"
        ports        = ["http"]
        network_mode = "host"
      }

      env {
        PUID = 1010
        PGID = 1010
        TZ   = "America/Denver"
      }

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}
