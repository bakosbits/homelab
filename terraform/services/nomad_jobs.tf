locals {
  jobs          = "${path.module}/nomad_jobs"
  domain        = var.domain
  consul_domain = var.consul_domain
}

resource "nomad_job" "storage-controller" {
  jobspec    = file("${local.jobs}/storage-controller.hcl")
}

resource "nomad_job" "storage-node" {
  jobspec    = file("${local.jobs}/storage-node.hcl")
}

resource "nomad_job" "auth" {
  jobspec = templatefile("${local.jobs}/auth.hcl",
    {
      consul_domain = local.consul_domain
  })
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "cloudflared" {
  jobspec    = file("${local.jobs}/cloudflared.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "docker-registry" {
  jobspec = file("${local.jobs}/docker-registry.hcl")
  detach  = false
  depends_on = [nomad_job.storage-controller, nomad_job.storage-node]  
}

resource "nomad_job" "docker-cleanup" {
  jobspec = file("${local.jobs}/docker-cleanup.hcl")  
}

resource "nomad_job" "drawio" {
  jobspec    = file("${local.jobs}/drawio.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "emulatorjs" {
  jobspec    = file("${local.jobs}/emulatorjs.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "flaresolverr" {
  jobspec    = file("${local.jobs}/flaresolverr.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "grafana" {
  jobspec = templatefile("${local.jobs}/grafana.hcl",
    {
      domain = local.domain
  })
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "home-assistant" {
  jobspec    = file("${local.jobs}/home-assistant.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "influxdb" {
  jobspec    = file("${local.jobs}/influxdb.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "jellyfin" {
  jobspec = templatefile("${local.jobs}/jellyfin.hcl",
    {
      domain = var.domain
  })
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "journalctl-cleanup" {
  jobspec = file("${local.jobs}/journalctl-cleanup.hcl")
}

resource "nomad_job" "loki" {
  jobspec    = file("${local.jobs}/loki.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "matter" {
  jobspec    = file("${local.jobs}/matter.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "mongo" {
  jobspec    = file("${local.jobs}/mongodb8.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "mosquitto" {
  jobspec    = file("${local.jobs}/mosquitto.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "motioneye" {
  jobspec    = file("${local.jobs}/motioneye.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "n8n" {
  jobspec    = file("${local.jobs}/n8n.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "nomad-cleanup" {
  jobspec = templatefile("${local.jobs}/nomad-cleanup.hcl",
    {
      nomad_url = var.nomad_url
  })
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "nginx" {
  jobspec    = file("${local.jobs}/nginx.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

# resource "nomad_job" "ollama" {
#   jobspec = file("${local.jobs}/ollama.hcl")
#   depends_on = [nomad_job.storage-controller]  
# }

resource "nomad_job" "pgweb" {
  jobspec    = file("${local.jobs}/pgweb.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "plex" {
  jobspec    = file("${local.jobs}/plex.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "postgres" {
  jobspec    = file("${local.jobs}/postgres.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "prowlarr" {
  jobspec    = file("${local.jobs}/prowlarr.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "prometheus" {
  jobspec    = file("${local.jobs}/prometheus.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "radarr" {
  jobspec    = file("${local.jobs}/radarr.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]
}

resource "nomad_job" "sabnzbd" {
  jobspec    = file("${local.jobs}/sabnzbd.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "samba" {
  jobspec    = file("${local.jobs}/samba.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "sonarr" {
  jobspec    = file("${local.jobs}/sonarr.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "telegraf" {
  jobspec    = file("${local.jobs}/telegraf.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}


resource "nomad_job" "traefik" {
  jobspec    = file("${local.jobs}/traefik.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "transmission" {
  jobspec    = file("${local.jobs}/transmission.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]
}

resource "nomad_job" "unifi" {
  jobspec    = file("${local.jobs}/unifi.hcl")
    depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]
}

resource "nomad_job" "vaultwarden" {
  jobspec    = file("${local.jobs}/vaultwarden.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "vector" {
  jobspec    = file("${local.jobs}/vector.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

resource "nomad_job" "wikijs" {
  jobspec    = file("${local.jobs}/wikijs.hcl")
  depends_on = [nomad_job.storage-controller, nomad_job.docker-registry]  
}

