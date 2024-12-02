variable "proxmox_api_url" {
  type        = string
  sensitive   = true
  description = "The url of proxmox"
}

variable "proxmox_api_user" {
  type        = string
  description = "The api user being used to connect the provider"
}

variable "proxmox_api_password" {
  type        = string
  sensitive   = true
  description = "The password for the api user being used by the provider"
}

variable "proxmox_node" {
  type        = string
  description = "The proxmox node being deployed to"
}

variable "iso_file" {
  type        = string
  description = "The iso file being used to create this image from"
}

variable "storage_pool" {
  type        = string
  description = "The storage pool used to house our vm images"
}

variable "bridge" {
  type        = string
  description = "The network bridge assigned to the vm guest" 
}

variable "vlan_tag" {
  type        = string
  description = "The vlan assigned to the vm guest" 
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
