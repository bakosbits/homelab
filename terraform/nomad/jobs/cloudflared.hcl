job "cloudflared" {
  datacenters = ["dc1"]
  type        = "service"

  group "tunnel" {
    count = 1


    service {
      name = "cloudflared-tunnel"
    }

    task "cloudflared-connector" {
      driver = "docker"

      config {
        image = "cloudflare/cloudflared:latest"
        network_mode = "host"
        # The command and args mirror the docker run command
        args = [
          "tunnel",
          "--no-autoupdate", 
          "run",
          "--token",
          "${CLOUDFLARED_TUNNEL_TOKEN}"        
        ]
      }

      # Define required resources for the task
      resources {
        cpu    = 100 # 100 MHz
        memory = 64  # 64 MB
      }
    
      template {
        env         = true
        destination = "secrets/cloudflared.env"
        data        = <<-EOF
        {{- with nomadVar "nomad/jobs/cloudflared" }}
          {{- range .Tuples -}}
            {{ .K }}={{ .V }}
          {{- end -}}
        {{- end -}}
        EOF
      }

    }
  }
}