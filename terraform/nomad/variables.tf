# Forward auth

variable "auth_domain" {
  type        = string
  description = "The domain of the homelab"
}

variable "auth_client_id" {
  type        = string
  description = "The client ID for the forwardAuth plugin for Traefik"
}

variable "auth_client_secret" {
  type        = string
  description = "The client secret for the forwardAuth plgin for Traefik"
}

variable "auth_secret" {
  type        = string
  description = "The secret for teh forwardAuth plugin for Traefik"
}

variable "auth_whitelist_email" {
  type        = string
  description = "The email to be whitelisted by the forwardAuth plugin"
}

# Grafana

variable "grafana_email" {
  type        = string
  description = "The username of the grafana admin"
}

variable "grafana_password" {
  type        = string
  description = "The password used by the grafana admin"
}

variable "grafana_url" {
  type        = string
  description = "The URL of the grafana instance"
}

variable "postgres_root_user" {
  type        = string
  description = "The root user for postgres"
}

variable "postgres_root_password" {
  type        = string
  description = "The password for the Postgres root user"
}

# Influxdb

variable "influxdb_password" {
  type        = string
  description = "The password for the influxdb root user"
}

variable "influxdb_user" {
  type        = string
  description = "The root user for influxdb"
}

# Samba

variable "samba_password" {
  type        = string
  description = "The password for samba"
}

variable "samba_share" {
  type        = string
  description = "The samba share"
}

variable "samba_uid" {
  type        = string
  description = "The UID for the samba user"
}

#Mongo

variable "mongo_password" {
  type        = string
  description = "The mongo password for the Unifi db"
}

variable "mongo_user" {
  type        = string
  description = "The mongo user for the unifi db"
}

variable "mongo_initdb_root_username" {
  type        = string
  description = "The mongo user for the auth db"
}

variable "mongo_initdb_root_password" {
  type        = string
  description = "The mongo password for the auth db"
}