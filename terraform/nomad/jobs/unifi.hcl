job "unifi" {
  datacenters = ["dc1"]
  type        = "service"

  group "unifi" {

    network {
      port "http" { static = "8443" }
    }

    volume "init-mongo" {
      type            = "csi"
      read_only       = true
      source          = "init-mongo"
      attachment_mode = "file-system"
      access_mode     = "multi-node-reader-only"
    } 

    volume "unifi" {
      type            = "csi"
      read_only       = false
      source          = "unifi"
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
    }  

    service {
      name = "unifi"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.unifi.entrypoints=websecure",
        "traefik.http.services.unifi.loadbalancer.server.scheme=https",
        "traefik.http.routers.unifi.middlewares=auth"
      ]

      check {
        type     = "tcp"
        path     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "unifi" {
      driver = "docker"

      config {
        image        = "linuxserver/unifi-network-application:8.5.6"
        network_mode = "host"
        ports        = ["http"]
      }

      volume_mount {
        volume      = "init-mongo"
        destination = "/docker-entrypoint-initdb.d/init-mongo.sh:ro"
      }

      volume_mount {
        volume      = "unifi"
        destination = "/config"
      }

      resources {
        cpu    = 1000
        memory = 1536
      }

      template {
        env         = true
        destination = "secrets/unifi.env"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/unifi" }}
          {{- range .Tuples }}
            {{ .K }}={{ .V }}
          {{- end }}
        {{- end }}
        EOF
      }
    }
  }
}