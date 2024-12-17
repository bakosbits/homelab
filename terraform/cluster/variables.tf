variable "proxmox_url" {
  type        = string
  description = "The url to Proxmox"
}

variable "proxmox_user" {
  type        = string
  description = "The user that Telmate will use to log into Proxmox"
}

variable "proxmox_password" {
  type        = string
  description = "The password for the user that Telmate will use to log into Proxmox"
}

variable "ciuser" {
  type        = string
  description = "The system user to be configured by cloud-init"
}

variable "cipassword" {
  type        = string
  description = "The system user's password to be configured by cloud-init"
}

variable "sshkeys" {
  type        = string
  description = "The system user's ssh keys to be configured by cloud-init"
}

variable "storage_pool" {
  type        = string
  description = "The storage pool for the system"
}

variable "bridge" {
  type        = string
  description = "The network bridge used by the virtual machines"
}

variable "vlan" {
  type        = number
  description = "The vlan used by the virtual machines"
}

variable "dns" {
  type = list(object({
    name        = string
    target_node = string
    clone       = string
    cores       = number
    memory      = number
    disk_size   = string
  }))
  default = []
}

variable "servers" {
  type = list(object({
    name        = string
    target_node = string
    clone       = string
    cores       = number
    memory      = number
    disk_size   = string
  }))
  default = []
}

variable "clients" {
  type = list(object({
    name        = string
    target_node = string
    clone       = string
    cores       = number
    memory      = number
    disk_size   = string
  }))
  default = []
}