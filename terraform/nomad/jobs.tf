locals {
  jobs = "${path.module}/jobs"
}

resource "nomad_job" "auth" {
  jobspec = templatefile("${local.jobs}/auth.hcl",
  {
    consul_domain = var.consul_domain
  })
}

resource "nomad_job" "cephrbd-controller" {
  jobspec = file("${local.jobs}/cephrbd-controller.hcl")
}

resource "nomad_job" "cephrbd-node" {
  jobspec = file("${local.jobs}/cephrbd-node.hcl")
}

resource "nomad_job" "cephfs-controller" {
  jobspec = file("${local.jobs}/cephfs-controller.hcl")
}

resource "nomad_job" "cephfs-node" {
  jobspec = file("${local.jobs}/cephfs-node.hcl")
}

resource "nomad_job" "docker-registry" {
  jobspec = file("${local.jobs}/docker-registry.hcl")
  depends_on = [ nomad_csi_volume.docker-registry ]
}

resource "nomad_job" "docker-cleanup" {
  jobspec = file("${local.jobs}/docker-cleanup.hcl")
}

resource "nomad_job" "drawio" {
  jobspec = file("${local.jobs}/drawio.hcl")
}

resource "nomad_job" "emulatorjs" {
  jobspec = file("${local.jobs}/emulatorjs.hcl")
  depends_on = [ 
    nomad_csi_volume.arcade_config,
    nomad_csi_volume.arcade_data,
   ]
}

resource "nomad_job" "flaresolverr" {
  jobspec = file("${local.jobs}/flaresolverr.hcl")
  depends_on = [ nomad_csi_volume.flaresolverr ]
}

resource "nomad_job" "grafana" {
  jobspec = file("${local.jobs}/grafana.hcl")
  depends_on = [ nomad_csi_volume.grafana ]
}

resource "nomad_job" "home-assistant" {
  jobspec = file("${local.jobs}/home-assistant.hcl")
  depends_on = [ nomad_csi_volume.hass ]
}

resource "nomad_job" "influxdb" {
  jobspec = file("${local.jobs}/influxdb.hcl")
  depends_on = [
    nomad_csi_volume.influxdb_config,
    nomad_csi_volume.influxdb_data,
   ]
}

resource "nomad_job" "jellyfin" {
  jobspec = file("${local.jobs}/jellyfin.hcl")
  depends_on = [ nomad_csi_volume.jellyfin ]
}

resource "nomad_job" "journalctl-cleanup" {
  jobspec = file("${local.jobs}/journalctl-cleanup.hcl")
}

resource "nomad_job" "loki" {
  jobspec = file("${local.jobs}/loki.hcl")
  depends_on = [ nomad_csi_volume.loki ]
}

resource "nomad_job" "matter" {
  jobspec = file("${local.jobs}/matter.hcl")
  depends_on = [ nomad_csi_volume.matter ]
}

resource "nomad_job" "mongo" {
  jobspec = file("${local.jobs}/mongo.hcl")
  depends_on = [ nomad_csi_volume.mongo ]
}

resource "nomad_job" "mosquitto" {
  jobspec = file("${local.jobs}/mosquitto.hcl")
  depends_on = [
    nomad_csi_volume.mosquitto-config,
    nomad_csi_volume.mosquitto-data,
    nomad_csi_volume.mosquitto-data,
   ]
}

resource "nomad_job" "nomad-cleanup" {
  jobspec = file("${local.jobs}/nomad-cleanup.hcl")
}

resource "nomad_job" "pgweb" {
  jobspec = file("${local.jobs}/pgweb.hcl")
  depends_on = [ nomad_job.docker-registry ]
}

resource "nomad_job" "plex" {
  jobspec = file("${local.jobs}/plex.hcl")
  depends_on = [ nomad_csi_volume.plex ]
}

resource "nomad_job" "postgres" {
  jobspec = file("${local.jobs}/postgres.hcl")
  depends_on = [ nomad_csi_volume.postgres ]
}

resource "nomad_job" "prowlarr" {
  jobspec = file("${local.jobs}/prowlarr.hcl")
  depends_on = [ nomad_csi_volume.prowlarr ]
}

resource "nomad_job" "radarr" {
  jobspec = file("${local.jobs}/radarr.hcl")
  depends_on = [ nomad_csi_volume.radarr ]
}

resource "nomad_job" "sabnzbd" {
  jobspec = file("${local.jobs}/sabnzbd.hcl")
  depends_on = [ nomad_csi_volume.sabnzbd ]
}

resource "nomad_job" "samba" {
  jobspec = file("${local.jobs}/samba.hcl")
  depends_on = [ nomad_csi_volume.samba ]
}

resource "nomad_job" "sonarr" {
  jobspec = file("${local.jobs}/sonarr.hcl")
  depends_on = [ nomad_csi_volume.sonarr ]
}

resource "nomad_job" "telegraf" {
  jobspec = file("${local.jobs}/telegraf.hcl")
}

resource "nomad_job" "traefik" {
  jobspec = file("${local.jobs}/traefik.hcl")
  depends_on = [ nomad_csi_volume.certs ]
}

resource "nomad_job" "transmission" {
  jobspec = file("${local.jobs}/transmission.hcl")
  depends_on = [ nomad_csi_volume.transmission ]
}

resource "nomad_job" "unifi" {
  jobspec    = file("${local.jobs}/unifi.hcl")
  depends_on = [nomad_csi_volume.unifi ]
}

resource "nomad_job" "vaultwarden" {
  jobspec = file("${local.jobs}/vaultwarden.hcl")
  depends_on = [ nomad_csi_volume.vaultwarden ]
}


resource "nomad_job" "wikijs" {
  jobspec = file("${local.jobs}/wikijs.hcl")
  depends_on = [ nomad_csi_volume.wikijs ]
}
