job "unifi" {
  datacenters = ["dc1"]
  type        = "service"

  group "unifi" {

    network {
      port "http"            { static = 8443 }
      port "unifi-adoption"  { static = 8080 }
      port "unifi-stun"      { static = 3478 }
      port "unifi-discovery" { static = 10001 }
      port "unifi-l2"        { static = 1900 }
    }

    service {
      name = "unifi"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.unifi-router.entrypoints=websecure",
        "traefik.http.services.unifi.loadbalancer.server.scheme=https",
      ]

      check {
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "unifi" {
      driver = "docker"
      
      config {
        force_pull = false        
        image      = "linuxserver/unifi-network-application:9.5.21"
        ports      = ["http", "unifi-adoption", "unifi-stun", "unifi-discovery", "unifi-l2"] 
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