resource "proxmox_vm_qemu" "coredns" {

  name        = "coredns"
  target_node = "pve03"
  clone       = "coredns-server"
  full_clone  = true

  cores     = 2
  sockets   = 1
  cpu       = "host"
  memory    = 1024
  scsihw    = "virtio-scsi-single"
  bootdisk  = "scsi0"
  bios      = "seabios"
  skip_ipv6 = true
  onboot    = true
  agent     = 1

  os_type    = "cloud_init"
  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = var.proxmox_sshkeys
  ipconfig0  = "ip=192.168.2.2/24,gw=192.168.2.1"

  network {
    model  = "virtio"
    bridge = var.bridge
    tag    = var.vlan_tag    
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size       = "4G"
          storage    = var.storage_pool
          iothread   = true
          emulatessd = true
          discard    = true
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = var.storage_pool
        }
      }
    }
  }

  lifecycle {
    ignore_changes = all
  }
}
