variable "consul_domain" {
  type        = string
  description = "The defult consul doman e.g. service.consul"
  default     = "service.consul"
}

variable "domain" {
  type        = string
  description = "The domain used to host the services"
}

variable "nomad_url" {
  type        = string
  description = "The url used to reach the nomad UI"
}

variable "consul_url" {
  type        = string
  description = "The url used to reach the consul UI"
}

variable "pfsense_url" {
  type        = string
  description = "The url used to reach the pfsense UI"

}

variable "pve_url" {
  type        = string
  description = "The url used to reach the proxmox UI"
}

variable "pve_backup_url" {
  type        = string
  description = "The url used to reach the proxmox backup UI"
}