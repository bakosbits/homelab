resource "consul_key_prefix" "hass" {
  path_prefix = "homelab/hass/"
  subkeys = {
    "automations.yaml"     = file("~/hass/automations.yaml"),
    "binary_sensors.yaml"  = file("~/hass/binary_sensors.yaml"),    
    "configuration.yaml"   = file("~/hass/configuration.yaml"),
    "covers.yaml"          = file("~/hass/covers.yaml"),
    "customize.yaml"       = file("~/hass/customize.yaml"),   
    "lights.yaml"          = file("~/hass/lights.yaml"),
    "scripts.yaml"         = file("~/hass/scripts.yaml"),
    "secrets.yaml"         = file("~/hass/secrets.yaml"),
    "service_account.json" = file("~/hass/service_account.json"),  
    "trusted_proxies.yaml" = file("~/hass/trusted_proxies.yaml"),   
    "fans.yaml"            = file("~/hass/fans.yaml"),
    "media_players.yaml"   = file("~/hass/media_players.yaml"),
    "switches.yaml"        = file("~/hass/switches.yaml"),
  }
}

resource "consul_key_prefix" "mosquitto" {
  path_prefix = "homelab/mosquitto/"
  subkeys = {
    "mosquitto.conf" = file("${path.module}/files/mosquitto/mosquitto.conf"),
    "password.txt"   = file("${path.module}/files/mosquitto/password.txt"),
  }
}

resource "consul_key_prefix" "prometheus" {
  path_prefix = "homelab/prometheus/"
  subkeys = {
    "prometheus.yml" = file("${path.module}/files/prometheus/prometheus.yaml"),
  }
}

resource "consul_key_prefix" "loki" {
  path_prefix = "homelab/loki/"
  subkeys = {
    "loki.yaml" = file("${path.module}/files/loki/loki.yaml"),
  }
}

resource "consul_key_prefix" "traefik" {
  path_prefix = "homelab/traefik/"
  subkeys = {
    "traefik.yaml" = file("${path.module}/files/traefik/traefik.yaml"),
    "dynamic.yaml" = file("${path.module}/files/traefik/dynamic.yaml"),
  }
}

resource "consul_key_prefix" "vector" {
  path_prefix = "homelab/vector/"
  subkeys = {
    "vector.toml" = file("${path.module}/files/vector/vector.toml"),
  }
}