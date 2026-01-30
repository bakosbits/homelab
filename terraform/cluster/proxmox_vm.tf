#####################################################################
# The primary resource for creating Consul, Nomad and CoreDNS hosts #
#####################################################################
resource "proxmox_virtual_environment_vm" "vm" {
  for_each = local.all_nodes  
  name        = each.value.name
  node_name   = each.value.target_node

  # The cloning configuration
  clone {
    vm_id = each.value.clone_id
    node_name = var.pve_nodes[2]
    full = true # True for full clone, false for linked clone
  }

cpu {
    type  = "host"
    cores = each.value.cores
  }

  memory {
    dedicated = each.value.memory
  }

  agent {
    enabled = true
  }
  
  network_device {
    bridge = var.bridge
    model  = "virtio"
  }  

disk {
    datastore_id = var.storage
    interface    = "scsi0"        # Must match the interface in your Packer template
    size         = each.value.disk_size
    iothread     = true
    discard      = "on"
    ssd          = true
  }


  initialization {

    datastore_id = var.storage
    interface = "ide0"

    user_account {
      username  = var.ciuser
      password  = var.cipassword      
      keys      = [var.sshkeys]
    }
    
    dns {
      servers = [each.value.nameserver]
      domain = var.domain
    }

    ip_config {
      ipv4 {
        address = "${each.value.ip}/24" 
        gateway = cidrhost(var.cluster_cidr, 1)
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.role_config[each.key].id    
  }


  lifecycle {
    ignore_changes = all
  }

depends_on = [proxmox_virtual_environment_file.role_config]
}
