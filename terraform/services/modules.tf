module "consul" {
  source = "../consul"
}

module "nomad" {
  source     = "../nomad"
  depends_on = [module.consul]

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
}