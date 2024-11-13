resource "proxmox_vm_qemu" "nomad-client" {

  depends_on = [resource.proxmox_vm_qemu.nomad-server]

  count       = 3
  name        = "client0${count.index+1}"
  target_node = "pve0${count.index+1}"
  clone       = "nomad-client"
  full_clone  = true

  cores     = 4
  sockets   = 1
  cpu       = "host"
  memory    = 10240
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
          size       = "24G"
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