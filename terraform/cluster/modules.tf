module "overwatch" {
  source = "../vm"

  for_each = {
    for idx, vm in var.overwatch : idx + 1 => vm
  }

  vmid        = each.value.vmid
  name        = each.value.name
  target_node = each.value.target_node

  clone = each.value.clone

  cores  = each.value.cores
  memory = each.value.memory

  ipconfig = each.value.ipconfig
  bridge   = var.bridge
  vlan     = var.vlan

  disk_size    = each.value.disk_size
  storage_pool = var.storage_pool

  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = var.sshkeys
}

module "dns" {
  source = "../vm"

  for_each = {
    for idx, vm in var.dns : idx + 1 => vm
  }

  vmid        = each.value.vmid
  name        = each.value.name
  target_node = each.value.target_node

  clone = each.value.clone

  cores  = each.value.cores
  memory = each.value.memory

  ipconfig = each.value.ipconfig
  bridge   = var.bridge
  vlan     = var.vlan

  disk_size    = each.value.disk_size
  storage_pool = var.storage_pool

  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = var.sshkeys
}

module "server" {
  source = "../vm"

  for_each = {
    for idx, vm in var.servers : idx + 1 => vm
  }

  vmid        = each.value.vmid
  name        = each.value.name
  target_node = each.value.target_node

  clone = each.value.clone

  cores  = each.value.cores
  memory = each.value.memory

  ipconfig = each.value.ipconfig
  bridge   = var.bridge
  vlan     = var.vlan

  disk_size    = each.value.disk_size
  storage_pool = var.storage_pool

  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = var.sshkeys
}


module "client" {
  source = "../vm"

  for_each = {
    for idx, vm in var.clients : idx + 1 => vm
  }

  vmid        = each.value.vmid
  name        = each.value.name
  target_node = each.value.target_node

  clone = each.value.clone

  cores  = each.value.cores
  memory = each.value.memory

  ipconfig = each.value.ipconfig
  bridge   = var.bridge
  vlan     = var.vlan

  disk_size    = each.value.disk_size
  storage_pool = var.storage_pool

  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = var.sshkeys

}

