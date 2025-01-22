job "transmission" {
  datacenters = ["dc1"]
  type        = "service"

  group "transmission" {

    network {
      port "http" { static = 9091 }
    }

    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.entrypoints=websecure",
        "traefik.http.routers.$${NOMAD_JOB_NAME}.middlewares=auth"
      ]

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "transmission" {
      driver = "docker"

      config {
        image = "lscr.io/linuxserver/transmission:latest"
        ports = ["http"]
        volumes = [
          "${job_volumes}/$${NOMAD_JOB_NAME}:/config",
          "${job_volumes}/media:/data",
          "${job_volumes}/media/downloads/torrents:/watch"
        ]
      }

      env {
        PUID = 1010
        PGID = 1010
        TZ   = "America/Denver"
      }

      resources {
        cpu    = 500
        memory = 768
      }
    }
  }
}