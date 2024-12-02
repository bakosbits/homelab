resource "consul_key_prefix" "home-assistant" {
  path_prefix = "homelab/hass/"
  subkeys = {
    "automations.yaml"     = file("/home/rab/hass/automations.yaml"),
    "binary_sensors.yaml"  = file("/home/rab/hass/binary_sensors.yaml"),    
    "configuration.yaml"   = file("/home/rab/hass/configuration.yaml"),
    "covers.yaml"          = file("/home/rab/hass/covers.yaml"),
    "customize.yaml"       = file("/home/rab/hass/customize.yaml"),   
    "lights.yaml"          = file("/home/rab/hass/lights.yaml"),
    "scripts.yaml"         = file("/home/rab/hass/scripts.yaml"),
    "secrets.yaml"         = file("/home/rab/hass/secrets.yaml"),
    "service_account.json" = file("/home/rab/hass/service_account.json"),  
    "trusted_proxies.yaml" = file("/home/rab/hass/trusted_proxies.yaml"),   
    "fans.yaml"            = file("/home/rab/hass/fans.yaml"),
    "media_players.yaml"   = file("/home/rab/hass/media_players.yaml"),
    "switches.yaml"        = file("/home/rab/hass/switches.yaml"),
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

