locals {
  jobs          = "${path.module}/jobs"
  domain        = var.domain
  consul_domain = var.consul_domain
  job_volumes   = var.job_volumes
}

resource "nomad_job" "auth" {
  jobspec = templatefile("${local.jobs}/auth.hcl",
  {   
    consul_domain = local.consul_domain
  })
}

resource "nomad_job" "docker-registry" {
  jobspec = templatefile("${local.jobs}/docker-registry.hcl",
  {
    job_volumes = local.job_volumes
  })
}

resource "nomad_job" "docker-cleanup" {
  jobspec = file("${local.jobs}/docker-cleanup.hcl")
}

resource "nomad_job" "drawio" {
  jobspec = file("${local.jobs}/drawio.hcl")
}

resource "nomad_job" "emulatorjs" {
  jobspec = templatefile("${local.jobs}/emulatorjs.hcl",
  {
    job_volumes = local.job_volumes
  })
}

resource "nomad_job" "flaresolverr" {
  jobspec = templatefile("${local.jobs}/flaresolverr.hcl",
  {
    job_volumes = local.job_volumes
  })
}

resource "nomad_job" "grafana" {
  jobspec = templatefile("${local.jobs}/grafana.hcl",
  {
    domain      = local.domain,   
    job_volumes = local.job_volumes
  })
}

resource "nomad_job" "home-assistant" {
  jobspec = templatefile("${local.jobs}/home-assistant.hcl",
  {
    job_volumes = local.job_volumes
  })
}

resource "nomad_job" "influxdb" {
  jobspec = templatefile("${local.jobs}/influxdb.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "jellyfin" {
  jobspec = templatefile("${local.jobs}/jellyfin.hcl",
  {
    domain      = var.domain
    job_volumes = local.job_volumes    
  })
}

resource "nomad_job" "journalctl-cleanup" {
  jobspec = file("${local.jobs}/journalctl-cleanup.hcl")
}

resource "nomad_job" "loki" {
  jobspec = templatefile("${local.jobs}/loki.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "matter" {
  jobspec = templatefile("${local.jobs}/matter.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "mongodb7" {
  jobspec = templatefile("${local.jobs}/mongodb7.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "mosquitto" {
  jobspec = templatefile("${local.jobs}/mosquitto.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "n8n" {
  jobspec = templatefile("${local.jobs}/n8n.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "nomad-cleanup" {
  jobspec = templatefile("${local.jobs}/nomad-cleanup.hcl",
  {
    nomad_url = var.nomad_url
  })
}

# resource "nomad_job" "ollama" {
#   jobspec = templatefile("${local.jobs}/ollama.hcl",
#   {
#     job_volumes = local.job_volumes
#   })  
# }

resource "nomad_job" "pgweb" {
  jobspec = file("${local.jobs}/pgweb.hcl")
}

resource "nomad_job" "plex" {
  jobspec = templatefile("${local.jobs}/plex.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "postgres" {
  jobspec = templatefile("${local.jobs}/postgres.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "prowlarr" {
  jobspec = templatefile("${local.jobs}/prowlarr.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "radarr" {
  jobspec = templatefile("${local.jobs}/radarr.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "sabnzbd" {
  jobspec = templatefile("${local.jobs}/sabnzbd.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "samba" {
  jobspec = templatefile("${local.jobs}/samba.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "sonarr" {
  jobspec = templatefile("${local.jobs}/sonarr.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "telegraf" {
  jobspec = file("${local.jobs}/telegraf.hcl")
}

resource "nomad_job" "traefik" {
  jobspec = templatefile("${local.jobs}/traefik.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "transmission" {
  jobspec = templatefile("${local.jobs}/transmission.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "unifi" {
  jobspec = templatefile("${local.jobs}/unifi.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "vaultwarden" {
  jobspec = templatefile("${local.jobs}/vaultwarden.hcl",
  {
    job_volumes = local.job_volumes
  })  
}

resource "nomad_job" "wikijs" {
  jobspec = templatefile("${local.jobs}/wikijs.hcl",
  {
    job_volumes = local.job_volumes
  })  
}