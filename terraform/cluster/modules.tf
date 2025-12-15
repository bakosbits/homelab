module "server" {
  source = "../vm"
  depends_on = [module.dns]  
  for_each = {
    for idx, vm in var.servers : idx + 1 => vm
  }

  vmid        = each.value.vmid
  name        = each.value.name
  target_node = each.value.target_node

  clone = each.value.clone

  cores  = each.value.cores
  memory = each.value.memory
  bridge   = var.bridge

  disk_size    = each.value.disk_size
  storage_pool = "rbd"

  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = var.sshkeys
  nameserver = var.nameserver
  searchdomain = var.searchdomain
  ipconfig = each.value.ipconfig
}


module "client" {
  source = "../vm"
  depends_on = [module.server]
  
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

  disk_size    = each.value.disk_size
  storage_pool = "rbd"

  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = var.sshkeys

}

module "dns" {
  source     = "../vm"
  count      = 1
  depends_on = [module.server]
  
  vmid        = var.dns[count.index].vmid
  name        = var.dns[count.index].name
  target_node = var.dns[count.index].target_node

  clone = var.dns[count.index].clone

  cores  = var.dns[count.index].cores
  memory = var.dns[count.index].memory

  ipconfig = var.dns[count.index].ipconfig
  bridge   = var.bridge

  disk_size    = var.dns[count.index].disk_size
  storage_pool = "rbd"

  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = var.sshkeys
}