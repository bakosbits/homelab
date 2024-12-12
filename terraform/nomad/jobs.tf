# resource "nomad_job" "cephrbd-controller" {
#   jobspec = file("${path.module}/jobs/cephrbd-controller.hcl")
# }

# resource "nomad_job" "cephrbd-node" {
#   jobspec = file("${path.module}/jobs/cephrbd-node.hcl")
# }

# resource "nomad_job" "cephfs-controller" {
#   jobspec = file("${path.module}/jobs/cephfs-controller.hcl")
# }

# resource "nomad_job" "cephfs-node" {
#   jobspec = file("${path.module}/jobs/cephfs-node.hcl")
# }

resource "nomad_job" "auth" {
  jobspec = file("${path.module}/jobs/auth.hcl")
}

resource "nomad_job" "docker-registry" {
  jobspec = file("${path.module}/jobs/docker-registry.hcl")
}

resource "nomad_job" "docker-cleanup" {
  jobspec = file("${path.module}/jobs/docker-cleanup.hcl")
}

resource "nomad_job" "drawio" {
  jobspec = file("${path.module}/jobs/drawio.hcl")
}

resource "nomad_job" "emulatorjs" {
  jobspec = file("${path.module}/jobs/emulatorjs.hcl")
}

resource "nomad_job" "flaresolverr" {
  jobspec = file("${path.module}/jobs/flaresolverr.hcl")
}

resource "nomad_job" "grafana" {
  jobspec = file("${path.module}/jobs/grafana.hcl")
}  

resource "nomad_job" "home-assistant" {
  jobspec = file("${path.module}/jobs/home-assistant.hcl")  
}

resource "nomad_job" "influxdb" {
  jobspec = file("${path.module}/jobs/influxdb.hcl")
}

resource "nomad_job" "jellyfin" {
  jobspec = file("${path.module}/jobs/jellyfin.hcl")
}

resource "nomad_job" "journalctl-cleanup" {
  jobspec = file("${path.module}/jobs/journalctl-cleanup.hcl")
}

resource "nomad_job" "loki" {
  jobspec = file("${path.module}/jobs/loki.hcl") 
}

resource "nomad_job" "matter" {
  jobspec = file("${path.module}/jobs/matter.hcl") 
}

resource "nomad_job" "mongo" {
  jobspec = file("${path.module}/jobs/mongo.hcl") 
}

resource "nomad_job" "mosquitto" {
  jobspec = file("${path.module}/jobs/mosquitto.hcl") 
}

resource "nomad_job" "nomad-cleanup" {
  jobspec = file("${path.module}/jobs/nomad-cleanup.hcl")
}

resource "nomad_job" "pgweb" {
  jobspec = file("${path.module}/jobs/pgweb.hcl")
}

resource "nomad_job" "plex" {
  jobspec = file("${path.module}/jobs/plex.hcl")
}

resource "nomad_job" "postgres" {
  jobspec = file("${path.module}/jobs/postgres.hcl")
}

resource "nomad_job" "prowlarr" {
  jobspec = file("${path.module}/jobs/prowlarr.hcl")
}

resource "nomad_job" "radarr" {
  jobspec = file("${path.module}/jobs/radarr.hcl")
}

resource "nomad_job" "sabnzbd" {
  jobspec = file("${path.module}/jobs/sabnzbd.hcl")
}

resource "nomad_job" "samba" {
  jobspec = file("${path.module}/jobs/samba.hcl")
}

resource "nomad_job" "sonarr" {
  jobspec = file("${path.module}/jobs/sonarr.hcl")
}

resource "nomad_job" "telegraf" {
  jobspec = file("${path.module}/jobs/telegraf.hcl")
}

resource "nomad_job" "traefik" {
  jobspec = file("${path.module}/jobs/traefik.hcl")
}

resource "nomad_job" "transmission" {
  jobspec = file("${path.module}/jobs/transmission.hcl")
}

resource "nomad_job" "unifi" {
  jobspec    = file("${path.module}/jobs/unifi.hcl")
  depends_on = [resource.nomad_job.mongo]
}

resource "nomad_job" "vaultwarden" {
  jobspec = file("${path.module}/jobs/vaultwarden.hcl")
}

# resource "nomad_job" "vector" {
#   jobspec = file("${path.module}/jobs/vector.hcl")
# }

resource "nomad_job" "wikijs" {
  jobspec = file("${path.module}/jobs/wikijs.hcl")
}

