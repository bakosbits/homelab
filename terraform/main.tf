terraform {
  backend "local" {}
}

module "proxmox" {
  source               = "./proxmox"
  ciuser               = var.ciuser
  cipassword           = var.cipassword
  proxmox_api_url      = var.proxmox_api_url
  proxmox_password     = var.proxmox_password
  proxmox_user         = var.proxmox_user
  proxmox_sshkeys      = var.proxmox_sshkeys
  proxmox_service_node = var.proxmox_service_node
  storage_pool         = var.storage_pool
  bridge               = var.bridge
  vlan_tag             = var.vlan_tag
}

module "consul" {
  source     = "./consul"
  depends_on = [module.proxmox.configured]
}

module "nomad" {
  source     = "./nomad"
  depends_on = [module.consul.configured]
  # Ceph
  ceph_userid  = var.ceph_userid
  ceph_userkey = var.ceph_userkey
  # Traefik forward auth
  auth_domain          = var.auth_domain
  auth_client_id       = var.auth_client_id
  auth_client_secret   = var.auth_client_secret
  auth_secret          = var.auth_secret
  auth_whitelist_email = var.auth_whitelist_email
  # Grafana
  grafana_url      = var.grafana_url
  grafana_email    = var.grafana_email
  grafana_password = var.grafana_password
  # Influxdb
  influxdb_user     = var.influxdb_user
  influxdb_password = var.influxdb_password
  # Mongo
  mongo_user                 = var.mongo_user
  mongo_password             = var.mongo_password
  mongo_initdb_root_username = var.mongo_initdb_root_username
  mongo_initdb_root_password = var.mongo_initdb_root_password
  # Postgres
  postgres_root_user     = var.postgres_root_user
  postgres_root_password = var.postgres_root_password
  # Samba
  samba_uid      = var.samba_uid
  samba_password = var.samba_password
  samba_share    = var.samba_share
}

