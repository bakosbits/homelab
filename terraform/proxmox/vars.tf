# Proxmox

variable "proxmox_api_url" {
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

variable "proxmox_service_node" {
  type        = string
  description = "The proxmox node that cluster services will be deployed to"
}

variable "ciuser" {
  type        = string
  description = "The system user to be configured by cloud-init"
}

variable "cipassword" {
  type        = string
  description = "The system user's password to be configured by cloud-init"
}

variable "proxmox_sshkeys" {
  type        = string
  description = "The system user's ssh keys to be configured by cloud-init"
}

variable "storage_pool" {
  type        = string
  description = "The storage pool for the systems"
}

variable "bridge" {
  type        = string
  description = "The network bridge used by the virtual machines"
}

variable "vlan_tag" {
  type        = string
  description = "The vlan used by the virtual machines"
}