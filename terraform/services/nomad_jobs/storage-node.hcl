job "storage-node" {
  datacenters = ["dc1"]
  type        = "system"

  group "node" {
    task "node" {
      driver = "docker"

      config {
        image = "registry.gitlab.com/rocketduck/csi-plugin-nfs:1.1.0"

      args = [
        "--type=node",
        "--node-id=${attr.unique.hostname}",
        "--nfs-server=192.168.1.225:/exports/cephfs/volumes",
        "--mount-options=nfsvers=4.1,noatime,nodiratime,soft,timeo=30,retrans=2,rsize=1048576,wsize=1048576",
        "--allow-nested-volumes"
      ]

        network_mode = "host"
        privileged   = true
      }

      csi_plugin {
        id        = "nfs"
        type      = "node"
        mount_dir = "/csi"
      }
    }
  }
}