locals {
  jobs = "${path.module}/jobs"
}

resource "nomad_job" "auth" {
  jobspec = templatefile("${local.jobs}/auth.hcl",
  {
    consul_domain = var.consul_domain
  })
}

resource "nomad_job" "docker-registry" {
  jobspec = file("${local.jobs}/docker-registry.hcl")
}

resource "nomad_job" "docker-cleanup" {
  jobspec = file("${local.jobs}/docker-cleanup.hcl")
}

resource "nomad_job" "drawio" {
  jobspec = file("${local.jobs}/drawio.hcl")
}

resource "nomad_job" "emulatorjs" {
  jobspec = file("${local.jobs}/emulatorjs.hcl")
}

resource "nomad_job" "flaresolverr" {
  jobspec = file("${local.jobs}/flaresolverr.hcl")
}

resource "nomad_job" "grafana" {
  jobspec = file("${local.jobs}/grafana.hcl")
}

resource "nomad_job" "home-assistant" {
  jobspec = file("${local.jobs}/home-assistant.hcl")
}

resource "nomad_job" "influxdb" {
  jobspec = file("${local.jobs}/influxdb.hcl")
}

resource "nomad_job" "jellyfin" {
  jobspec = file("${local.jobs}/jellyfin.hcl")
}

resource "nomad_job" "journalctl-cleanup" {
  jobspec = file("${local.jobs}/journalctl-cleanup.hcl")
}

resource "nomad_job" "loki" {
  jobspec = file("${local.jobs}/loki.hcl")
}

resource "nomad_job" "matter" {
  jobspec = file("${local.jobs}/matter.hcl")
}

resource "nomad_job" "mongodb7" {
  jobspec = file("${local.jobs}/mongodb7.hcl")
}

resource "nomad_job" "mosquitto" {
  jobspec = file("${local.jobs}/mosquitto.hcl")
}

resource "nomad_job" "nomad-cleanup" {
  jobspec = templatefile("${local.jobs}/nomad-cleanup.hcl",
  {
    nomad_server = var.nomad_server
  })
}

resource "nomad_job" "pgweb" {
  jobspec = file("${local.jobs}/pgweb.hcl")
}

resource "nomad_job" "plex" {
  jobspec = file("${local.jobs}/plex.hcl")
}

resource "nomad_job" "postgres" {
  jobspec = file("${local.jobs}/postgres.hcl")
}

resource "nomad_job" "prowlarr" {
  jobspec = file("${local.jobs}/prowlarr.hcl")
}

resource "nomad_job" "radarr" {
  jobspec = file("${local.jobs}/radarr.hcl")
}

resource "nomad_job" "sabnzbd" {
  jobspec = file("${local.jobs}/sabnzbd.hcl")
}

resource "nomad_job" "samba" {
  jobspec = file("${local.jobs}/samba.hcl")
}

resource "nomad_job" "sonarr" {
  jobspec = file("${local.jobs}/sonarr.hcl")
}

resource "nomad_job" "telegraf" {
  jobspec = file("${local.jobs}/telegraf.hcl")
}

resource "nomad_job" "traefik" {
  jobspec = file("${local.jobs}/traefik.hcl")
}

resource "nomad_job" "transmission" {
  jobspec = file("${local.jobs}/transmission.hcl")
}

resource "nomad_job" "unifi" {
  jobspec    = file("${local.jobs}/unifi.hcl")
}

resource "nomad_job" "vaultwarden" {
  jobspec = file("${local.jobs}/vaultwarden.hcl")
}

resource "nomad_job" "wikijs" {
  jobspec = file("${local.jobs}/wikijs.hcl")
}