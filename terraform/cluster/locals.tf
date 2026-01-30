##########################################################
# Local vars to support the vm resource in proxmox_vm.tf #
##########################################################
locals {

  dns_offset     = 2
  manager_offset  = 71
  worker_offset  = 81

  dns_ip     = [local.dns_node.ip]
  worker_ips = [for w in local.worker_nodes : w.ip]
  manager_ips = [for w in local.manager_nodes : w.ip]

  all_nodes = {
    for node in concat([local.dns_node], local.manager_nodes, local.worker_nodes) : node.name => node
  }  

  # DNS node as a single-element list
  dns_node = {
      name        = format("dns%02d", local.dns_offset)
      ip          = cidrhost(var.cluster_cidr, local.dns_offset)
      target_node = var.pve_nodes[0]
      role        = "dns"
      clone       = "dns-tpl"
      clone_id    = 9001
      disk_size   = 8
      cores       = 2
      memory      = 2048
      nameserver  = "127.0.0.1"
  }

  # managers
  manager_nodes = [
    for i in range(var.manager_count) : {
      name        = format("manager%02d", i + 1)
      ip          = cidrhost(var.cluster_cidr, local.manager_offset + i)
      target_node = var.pve_nodes[i % length(var.pve_nodes)]
      role        = "manager"
      clone       = "manager-tpl"
      clone_id    = 9002
      disk_size   = 8
      cores       = 4
      memory      = 8192
      nameserver  = var.nameserver
    }
  ]

  # workers
  worker_nodes = [
    for i in range(var.worker_count) : {
      name        = format("worker%02d", i + 1)
      ip          = cidrhost(var.cluster_cidr, local.worker_offset + i)
      target_node = var.pve_nodes[i % length(var.pve_nodes)]
      role        = "worker"
      clone       = "worker-tpl"
      clone_id    = 9003      
      disk_size   = 30
      cores       = 12
      memory      = 65536
      nameserver  = var.nameserver
    }
  ]
}
