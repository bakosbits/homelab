job "cephrbd-node" {
  datacenters = ["dc1"]
  type        = "system"

  group "cephrbd-node" {
    
    network { 
      port "metrics" {} 
    }
   
    service {
      name = "cephrbd-node"
      port = "metrics"
    }
    
    task "cephrbd-node" {
      driver = "docker"

      config {
        image = "quay.io/cephcsi/cephcsi:v3.13.0"
        privileged = true
        args = [
          "--type=rbd",
          "--drivername=rbd.csi.ceph.com",
          "--nodeserver=true",
          "--endpoint=unix://csi/csi.sock",
          "--nodeid=${node.unique.name}",
          "--instanceid=${node.unique.name}-node",
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
              size = 1000000 # size in bytes
            }
          }
        ]
      }

      csi_plugin {
        id        = "cephrbd"
        type      = "node"
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
          [{"clusterID": "820b0f5c-cee3-40a7-b5d5-0aada0355612","monitors": ["192.168.1.10","192.168.1.11","192.168.1.12"] }]
        EOF
      }  
    }
  }
}