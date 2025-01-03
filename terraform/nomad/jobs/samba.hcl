job "samba" {
  datacenters = ["dc1"]
  type        = "service"

  group "samba" {

    network {
      port "smb" { static = "445" }
    }

    volume "samba" {
      type            = "csi"
      source          = "samba"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }

    service {
      name = "samba"
      port = "smb"

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "samba" {
      driver = "docker"

      config {
        image        = "servercontainers/samba:smbd-only-a3.19.0-s4.18.9-r0"
        ports        = ["smb"]
        network_mode = "host"
      }

      volume_mount {
        volume      = "samba"
        destination = "/shares/homelab"
      }

      resources {
        cpu    = 200
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
