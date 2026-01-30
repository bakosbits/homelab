locals {
  files  = "${path.module}/consul_files"
}

resource "consul_key_prefix" "hass" {
  path_prefix = "homelab/hass/"
  subkeys = {
    "automations.yaml"      = file("~/hass/automations.yaml"),
    "binary_sensors.yaml"   = file("~/hass/binary_sensors.yaml"),    
    "configuration.yaml"    = file("~/hass/configuration.yaml"),
    "covers.yaml"           = file("~/hass/covers.yaml"),
    "customize.yaml"        = file("~/hass/customize.yaml"),   
    "google_assistant.yaml" = file("~/hass/google_assistant.yaml"),
    "lights.yaml"           = file("~/hass/lights.yaml"),
    "scripts.yaml"          = file("~/hass/scripts.yaml"),
    "secrets.yaml"          = file("~/hass/secrets.yaml"),
    "service_account.json"  = file("~/hass/service_account.json"),  
    "trusted_proxies.yaml"  = file("~/hass/trusted_proxies.yaml"),   
    "fans.yaml"             = file("~/hass/fans.yaml"),
    "media_players.yaml"    = file("~/hass/media_players.yaml"),
    "switches.yaml"         = file("~/hass/switches.yaml"),
  }
}

resource "consul_key_prefix" "mqtt" {
  path_prefix = "homelab/mqtt/"
  subkeys = {
    "mosquitto.conf" = file("${local.files}/mqtt/mosquitto.conf"),
  }
}

resource "consul_key_prefix" "prometheus" {
  path_prefix = "homelab/prometheus/"
  subkeys = {
    "prometheus.yml" = file("${local.files}/prometheus/prometheus.yaml"),
  }
}

resource "consul_key_prefix" "init_mongo" {
  path_prefix = "homelab/init_mongo/"
  subkeys = {
    "init-mongo.sh" = file("${local.files}/init_mongo/init-mongo.sh"),
  }
}

resource "consul_key_prefix" "loki" {
  path_prefix = "homelab/loki/"
  subkeys = {
    "loki.yaml" = file("${local.files}/loki/loki.yaml"),
  }
}

resource "consul_key_prefix" "telegraf" {
  path_prefix = "homelab/telegraf/"
  subkeys = {
    "config.toml" = file("${local.files}/telegraf/config.toml"),
  }
}

resource "consul_key_prefix" "traefik" {
  path_prefix = "homelab/traefik/"
  subkeys = {
    "traefik.yaml" = templatefile("${local.files}/traefik/traefik.yaml",
    {
      domain = var.domain
    }),
    
    "dynamic.yaml" = templatefile("${local.files}/traefik/dynamic.yaml",
    {
      domain         = var.domain
      consul_domain  = var.consul_domain
      nomad_url      = var.nomad_url
      consul_url     = var.consul_url
      pfsense_url    = var.pfsense_url
      pve_url        = var.pve_url
      pve_backup_url = var.pve_backup_url
    }),
  }
}

resource "consul_key_prefix" "vector" {
  path_prefix = "homelab/vector/"
  subkeys = {
    "vector.toml" = file("${local.files}/vector/vector.toml"),
  }
}
