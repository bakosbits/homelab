variable "proxmox_url" {
  type        = string
  default     = "http://192.168.1.10:8006/api2/json"
  description = "The url of proxmox"
}

variable "proxmox_user" {
  type        = string
  default     = "root@pam"
  description = "The api user being used to connect the provider"
}

variable "proxmox_password" {
  type        = string
  default     = "real.m0n"
  sensitive   = true
  description = "The password for the api user being used by the provider"
}

variable "proxmox_node" {
  default     = "pve03"
  type        = string
  description = "The proxmox node being deployed to"
}

variable "ssh_username" {
  type       = string
  default    = "root"
  sensitive  = true
  description = "The user being used for provisioning"
}

variable "ssh_password" {
  type        = string
  default     = "packer"
  sensitive   = true
  description = "The password of the provisioning user"  
}
