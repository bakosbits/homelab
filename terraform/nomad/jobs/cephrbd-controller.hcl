job "cephrbd-controller" {
  datacenters = ["dc1"]
  type        = "service"

  group "cephrbd-controller" {
    
    network { 
      port "metrics" {} 
    }
   
    service {
      name = "$${NOMAD_JOB_NAME}"
      port = "metrics"
    }

    task "cephrbd-controller" {
      driver = "docker"

      config {
        image = "quay.io/cephcsi/cephcsi:v3.12.2"
        args = [
          "--type=rbd",
          "--controllerserver=true",
          "--drivername=rbd.csi.ceph.com",
          "--endpoint=unix://csi/csi.sock",
          "--nodeid=${node.unique.name}",
          "--instanceid=${node.unique.name}-controller",
          "--pidlimit=-1",
          "--logtostderr=true",
          "--v=5",
          "--metricsport=$${NOMAD_PORT_metrics}"
        ]

        volumes = [
          "./local/config.json:/etc/ceph-csi-config/config.json",
          "/lib/modules:/lib/modules"          
        ]

        mounts = [
          {
            type     = "tmpfs"
            target   = "/tmp/csi/keys"
            readonly = false
            tmpfs_options = {
              size = 1000000 # in bytes
            }
          }
        ]
      }
      
      csi_plugin {
        id        = "cephrbd"
        type      = "controller"
        mount_dir = "/csi"
      }

      resources {
        cpu    = 500
        memory = 256
      }

      template {
        destination = "local/config.json"
        change_mode = "restart"
        data        = <<-EOF
          [{ "clusterID": "820b0f5c-cee3-40a7-b5d5-0aada0355612","monitors": ["192.168.1.10","192.168.1.11","192.168.1.12"] }]
        EOF
      }
    }
  }
}