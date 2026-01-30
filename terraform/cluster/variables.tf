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

variable "pve_nodes" {
  type    = list(string)
  default = ["pve01", "pve02", "pve03"]
}

variable "ciuser" {
  type        = string
  description = "The system user to be configured by cloud-init"
  default     = ""
}

variable "cipassword" {
  type        = string
  description = "The system user's password to be configured by cloud-init"
  default     = ""
}

variable "sshkeys" {
  type        = string
  description = "The system user's ssh keys to be configured by cloud-init"
  default     = ""
}

variable "manager_count" {
  type    = number
  default = 3
}

variable "worker_count" {
  type    = number
  default = 3
}

variable "cluster_cidr" {
  type    = string
  default = "192.168.1.0/24"
}

variable "name" {
  type        = string
  description = "The name of the vm"
  default     = ""
}

variable "target_node" {
  type        = string
  description = "The proxmox node the vm is deplyed to"
  default     = ""
}

variable "cores" {
  type        = string
  description = "The number of cores for the vm"
  default     = ""
}

variable "disk_size" {
  type        = string
  description = "The size of the backing disk for the vm"
  default     = ""
}

variable "domain" {
  type        = string
  description = "The domain that will be used for cluster apps"
  default     = ""
}

variable "role" {
  type        = string
  description = "The role of the vm"
  default     = ""
}

variable "ipconfig" {
  type        = string
  description = "The ip config for the host"
  default     = ""
}

variable "nameserver" {
  type        = string
  description = "The nameserver record for the host and coredns"
  default     = ""
}

variable "searchdomain" {
  type        = string
  description = "The searchdomain for the host"
  default     = ""
}

variable "storage" {
  type        = string
  description = "The backing storage for the vm"
  default     = "rbd"
}

variable "config_storage" {
  type        = string
  description = "The backing storage for the vm"
  default     = "cephfs"
}

variable "vlan_tag" {
  type        = string
  description = "The vlan tag for the host"
  default     = ""
}

variable "bridge" {
  type        = string
  description = "The network bridge for the host"
  default     = "vmbr2"
}

variable "memory" {
  type        = string
  description = "The amount of ram for the vm"
  default     = "rbd"
}

variable "clone" {
  type        = string
  description = "The image to clone the vm from"
  default     = "rbd"
}

variable "datacenter" {
  type        = string
  description = "The datacenter as defined in nomad"
  default     = "dc1"
}

variable "clone_id" {
  type        = string
  description = "The vmid of the template to clone from"
  default     = ""

}


