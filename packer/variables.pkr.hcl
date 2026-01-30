variable "proxmox_url" {
  type        = string
  description = "The url of proxmox"
}

variable "proxmox_user" {
  type        = string
  description = "The api user being used to connect the provider"
}

variable "proxmox_password" {
  type        = string
  sensitive   = true
  description = "The password for the api user being used by the provider"
}

variable "proxmox_node" {
  type        = string
  description = "The proxmox node being deployed to"
}

variable "ssh_username" {
  type       = string
  sensitive  = true
  description = "The user being used for provisioning"
}

variable "ssh_password" {
  type        = string
  sensitive   = true
  description = "The password of the provisioning user"  
}