job "docker-registry" {
  datacenters = ["dc1"]
  type        = "service"

  group "docker-registry" {

    network {
      port "http" { static = "5000" }
    }

    service {
      port = "http"
      name = "docker-registry"

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "docker-registry" {
      driver = "docker"

      config {
        image        = "registry:2.8.3"
        network_mode = "host"
        ports        = ["http"]
      }

      env {
        REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY = "/data"
        REGISTRY_HTTP_ADDR                        = "${NOMAD_ADDR_http}"
        REGISTRY_PROXY_REMOTEURL                  = "https://registry-1.docker.io"
      }

      resources {
        cpu    = 20
        memory = 256
      }
    }
  }
}
