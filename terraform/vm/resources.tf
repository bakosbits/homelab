resource "proxmox_vm_qemu" "vm" {

  vmid        = var.vmid
  name        = var.name
  target_node = var.target_node
  clone       = var.clone
  full_clone  = true

  cores     = var.cores
  sockets   = 1
  cpu_type  = "host"
  memory    = var.memory
  scsihw    = "virtio-scsi-single"
  bootdisk  = "scsi0"
  skip_ipv6 = true
  onboot    = true
  agent     = 1

  os_type    = "cloud_init"
  ciuser     = var.ciuser
  cipassword = var.cipassword
  ciupgrade  = true
  sshkeys    = var.sshkeys
  ipconfig0  = var.ipconfig

  network {
    id     = 0
    model  = "virtio"
    bridge = var.bridge
    tag    = var.vlan        
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size       = var.disk_size
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