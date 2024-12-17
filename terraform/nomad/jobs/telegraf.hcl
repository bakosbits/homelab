job "telegraf" {
  datacenters = ["dc1"]
  type        = "system"

  group "telegraf" {

    network {
      port "http" { to = "9273" }
    }

    task "telegraf" {
      driver = "docker"

      service {
        name = "telegraf"
        port = "http"

        check {
          type     = "tcp"
          interval = "5s"
          timeout  = "2s"
        }
      }

      config {
        image = "telegraf:1.31.2"
        ports = ["http"]
        args = [
          "--config=/local/config.yaml",
        ]
      }

      resources {
        cpu    = 100
        memory = 128
      }

      template {
        data        = <<-EOH
        [global_tags]
          realm = 'home'
          role = 'nomad'
        [agent]
        [[outputs.prometheus_client]]
          listen = ':9273'
        [[inputs.cpu]]
          percpu = true
          totalcpu = true
        [[inputs.disk]]
          ignore_fs = ['tmpfs', 'devtmpfs']
        [[inputs.diskio]]
        [[inputs.kernel]]
        [[inputs.mem]]
        [[inputs.net]]
        [[inputs.ntpq]]
        [[inputs.processes]]
        [[inputs.swap]]
        [[inputs.system]]
        EOH
        destination = "local/config.yaml"
        env         = false
      }
    }
  }
}
