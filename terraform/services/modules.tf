module "consul" {
  source = "../consul"

  domain         = var.domain
  consul_domain  = var.consul_domain
  nomad_url      = var.nomad_url
  consul_url     = var.consul_url
  pfsense_url    = var.pfsense_url
  pve_url        = var.pve_url
  pve_backup_url = var.pve_backup_url
}

module "nomad" {
  source     = "../nomad"
  depends_on = [module.consul]

  consul_domain = var.consul_domain
  nomad_url  = var.nomad_url

  ceph_userid  = var.ceph_userid
  ceph_userkey = var.ceph_userkey

  auth_domain          = var.auth_domain
  auth_client_id       = var.auth_client_id
  auth_client_secret   = var.auth_client_secret
  auth_secret          = var.auth_secret
  auth_whitelist_email = var.auth_whitelist_email

  grafana_url      = var.grafana_url
  grafana_email    = var.grafana_email
  grafana_password = var.grafana_password

  influxdb_user     = var.influxdb_user
  influxdb_password = var.influxdb_password

  mongo_user                 = var.mongo_user
  mongo_password             = var.mongo_password
  mongo_initdb_root_username = var.mongo_initdb_root_username
  mongo_initdb_root_password = var.mongo_initdb_root_password

  postgres_root_user     = var.postgres_root_user
  postgres_root_password = var.postgres_root_password

  samba_uid      = var.samba_uid
  samba_password = var.samba_password
  samba_share    = var.samba_share

  mqtt_user     = var.mqtt_user
  mqtt_password = var.mqtt_password

}