job "unifi" {
  datacenters = ["dc1"]
  type        = "service"

  group "unifi" {

    network {
      port "http" { static = "8443" }
      # port "unifi-adoption" { static = "8080" }
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

    # service {
    #   name = "unifi-adoption"
    #   port = "unifi-adoption"
    #   tags = [
    #     "traefik.enable=true",
    #     "traefik.tcp.routers.unifi-adoption.entrypoints=unifi-adoption",
    #     "traefik.tcp.routers.unifi-adoption.rule=HostSNI(`*`)",
    #     "traefik.tcp.services.unifi-adoption.loadBalancer.server.port=$${NOMAD_HOST_PORT_unifi-adoption}"
    #   ]

    #   check {
    #     type     = "tcp"
    #     port     = "unifi-adoption"
    #     interval = "10s"
    #     timeout  = "2s"
    #   }

    }

    task "unifi" {
      driver = "docker"

      config {
        image        = "linuxserver/unifi-network-application:9.4.19"
        network_mode = "host"
        ports        = ["http"]
        volumes = [       
          "/mnt/volumes/unifi:/config"
        ]
      }

      resources {
        cpu    = 1500
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