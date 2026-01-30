job "samba" {
  datacenters = ["dc1"]
  type        = "service"

  group "samba" {

    network {
      port "http" { static = "445" }
    }

    service {
      name = "samba"
      port = "http"

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "samba" {
      driver = "docker"

      config {
        image = "dockurr/samba"
        ports = ["http"]
        volumes = [
          "/mnt/volumes:/storage"
        ]
      }

      resources {
        cpu    = 250
        memory = 256
      }

      template {
        env         = true
        destination = "secrets/env"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/samba" }}
          {{- range .Tuples }}
            {{ .K }}={{ .V }}
          {{- end }}
        {{- end }}
        EOF
      }
    }
  }
}
