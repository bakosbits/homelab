job "vector" {
  datacenters = ["dc1"]  
  type        = "system"

  group "vector" {

    network {
      port "api" { static = 8686 }
    }

    volume "docker-sock" {
      type      = "host"
      source    = "docker-sock-ro"
      read_only = true
    }

    service {
      name = "vector"
      port = "api"

      check {
        type     = "tcp"
        port     = "api"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "vector" {
      driver = "docker"
      config {
        image        = "timberio/vector:0.41.X-debian"
        network_mode = "host"
        ports        = ["api"]
      }

      kill_timeout = "30s"

      volume_mount {
        volume      = "docker-sock"
        destination = "/var/run/docker.sock"
        read_only   = true
      }

      env {
        VECTOR_CONFIG          = "local/vector.toml"
        VECTOR_REQUIRE_HEALTHY = "false"
      }

      template {
        destination   = "local/vector.toml"
        change_mode   = "signal"
        change_signal = "SIGHUP"
        data          = <<-EOF
        {{- key "homelab/vector/vector.toml"}}
        EOF
      }
      resources {
        cpu    = 500
        memory = 500
      }
    }
  }
}