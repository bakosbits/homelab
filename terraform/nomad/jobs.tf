locals {
  jobs          = "${path.module}/jobs"
  domain        = var.domain
  consul_domain = var.consul_domain
}

# resource "nomad_job" "cephfs-controller" {
#   jobspec = file("${local.jobs}/cephfs-controller.hcl")
# }

# resource "nomad_job" "cephfs-node" {
#   jobspec = file("${local.jobs}/cephfs-node.hcl")
# }

resource "nomad_job" "auth" {
  jobspec = templatefile("${local.jobs}/auth.hcl",
  {   
    consul_domain = local.consul_domain
  })
}

resource "nomad_job" "cloudflared" {
  jobspec = file("${local.jobs}/cloudflared.hcl")
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

# resource "nomad_job" "emulatorjs" {
#   jobspec = file("${local.jobs}/emulatorjs.hcl")
# }

resource "nomad_job" "flaresolverr" {
  jobspec = file("${local.jobs}/flaresolverr.hcl")
}

resource "nomad_job" "grafana" {
  jobspec = templatefile("${local.jobs}/grafana.hcl",
  {
    domain = local.domain   
  })
}

resource "nomad_job" "home-assistant" {
  jobspec = file("${local.jobs}/home-assistant.hcl")
}

resource "nomad_job" "influxdb" {
  jobspec = file("${local.jobs}/influxdb.hcl")  
}

resource "nomad_job" "jellyfin" {
  jobspec = templatefile("${local.jobs}/jellyfin.hcl",
  {
    domain = var.domain
  })
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

resource "nomad_job" "mongo" {
  jobspec = file("${local.jobs}/mongodb8.hcl")  
}

resource "nomad_job" "mosquitto" {
  jobspec = file("${local.jobs}/mosquitto.hcl")  
}

resource "nomad_job" "motioneye" {
  jobspec = file("${local.jobs}/motioneye.hcl")  
}

resource "nomad_job" "n8n" {
  jobspec = file("${local.jobs}/n8n.hcl")  
}

resource "nomad_job" "nomad-cleanup" {
  jobspec = templatefile("${local.jobs}/nomad-cleanup.hcl",
  {
    nomad_url = var.nomad_url
  })
}

# resource "nomad_job" "nginx" {
#   jobspec = file("${local.jobs}/nginx.hcl")  
# }

# resource "nomad_job" "ollama" {
#   jobspec = file("${local.jobs}/ollama.hcl")
# }

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
  jobspec = file("${local.jobs}/radarr.hcl" )  
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

# resource "nomad_job" "telegraf" {
#   jobspec = file("${local.jobs}/telegraf.hcl")
# }
#

resource "nomad_job" "traefik" {
  jobspec = file("${local.jobs}/traefik.hcl")
}

resource "nomad_job" "transmission" {
  jobspec = file("${local.jobs}/transmission.hcl")  
}

resource "nomad_job" "unifi" {
  jobspec = file("${local.jobs}/unifi.hcl")
}

# resource "nomad_job" "vaultwarden" {
#   jobspec = file("${local.jobs}/vaultwarden.hcl")  
# }

# resource "nomad_job" "wikijs" {
#   jobspec = file("${local.jobs}/wikijs.hcl")  
# }

# resource "nomad_job" "windmill" {
#   jobspec = file("${local.jobs}/windmill.hcl")  
# }