resource "consul_key_prefix" "home-assistant" {
  path_prefix = "homelab/hass/"
  subkeys = {
    "automations.yaml"     = file("${path.module}/files/home-assistant/automations.yaml"),
    "configuration.yaml"   = file("${path.module}/files/home-assistant/configuration.yaml"),
    "covers.yaml"          = file("${path.module}/files/home-assistant/covers.yaml"),
    "customize.yaml"       = file("${path.module}/files/home-assistant/customize.yaml"),   
    "lights.yaml"          = file("${path.module}/files/home-assistant/lights.yaml"),
    "scripts.yaml"         = file("${path.module}/files/home-assistant/scripts.yaml"),
    "secrets.yaml"         = file("${path.module}/files/home-assistant/secrets.yaml"),
    "service_account.json" = file("${path.module}/files/home-assistant/service_account.json"),  
    "trusted_proxies.yaml" = file("${path.module}/files/home-assistant/trusted_proxies.yaml"),                
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

