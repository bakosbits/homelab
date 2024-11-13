resource "proxmox_vm_qemu" "graylog" {

  name        = "graylog"
  vmid        = "200"
  target_node = "pve02"
  clone       = "graylog-server"
  full_clone  = true

  cores     = 8
  sockets   = 1
  cpu       = "host"
  memory    = 16384
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
  ipconfig0  = "ip=dhcp"

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

