variable "vmid" {
  type        = string
  description = "The id of the host"
}

variable "name" {
  type        = string
  description = "The name of the host"
  default     = "base"
}

variable "target_node" {
  type        = string
  description = "The Proxmox host to deply to"
  default     = "pve01"
}

variable "clone" {
  type        = string
  description = "The image to clone"
  default     = "base"

}

variable "cores" {
  type        = number
  description = "The qty of cores the host should have"
  default     = 2
}

variable "memory" {
  type        = number
  description = "The amount of ram for the host"
  default     = 2048
}

variable "disk_size" {
  type        = string
  description = "The disk size for the system"
  default     = "6G"
}

variable "storage_pool" {
  type        = string
  description = "The storage pool for the system"
  default     = "rbd"
}

variable "bridge" {
  type        = string
  description = "The network bridge used by the virtual machines"
  default     = "vmbr2"
}


variable "ipconfig" {
  type        = string
  description = "The ip used by the virtual machines"
  default     = "ip=dhcp"
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