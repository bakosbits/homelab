job "sabnzbd" {
  datacenters = ["dc1"]
  type        = "service"

  group "sabnzbd" {

    network {
      port "http" { to = "8080" }
    }

    service {
      port = "http"
      name = "$${NOMAD_JOB_NAME}"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.entrypoints=websecure",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.middlewares=auth"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "sabnzbd" {
      driver = "docker"

      config {
        image = "linuxserver/sabnzbd:4.3.2"
        ports = ["http"]
        volumes = [
          "${job_volumes}/sabnzbd:/config",
          "${job_volumes}/media:/data"
        ]
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
