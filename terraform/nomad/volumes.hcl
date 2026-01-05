
resource "nomad_csi_volume" "arcade_config" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "arcade_config"
  name         = "arcade_config"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "arcade_data" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "arcade_data"
  name         = "arcade_data"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "docker-registry" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "docker-registry"
  name         = "docker-registry"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "vaultwarden" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "vaultwarden"
  name         = "vaultwarden"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "flaresolverr" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "flaresolverr"
  name         = "flaresolverr"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "grafana" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "grafana"
  name         = "grafana"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "hass" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "hass"
  name         = "hass"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "influxdb_config" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "influxdb_config"
  name         = "influxdb_config"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }
  
  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "influxdb_data" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "influxdb_data"
  name         = "influxdb_data"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "matter" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "matter"
  name         = "matter"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "mongo" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "mongo"
  name         = "mongo"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "mosquitto-config" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "mosquitto-config"
  name         = "mosquitto-config"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "mosquitto-data" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "mosquitto-data"
  name         = "mosquitto-data"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "mosquitto-log" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "mosquitto-log"
  name         = "mosquitto-log"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

#  resource "nomad_csi_volume" "loki_data" {

#    lifecycle {
#      prevent_destroy = true
#    }

#    plugin_id    = "cephfs "
#    volume_id    = "loki_data"
#    name         = "loki_data"

#    capability {
#      access_mode     = "single-node-writer"
#      attachment_mode = "file-system"
#    }

#    secrets = {
#      userID  = var.ceph_userid
#      userKey = var.ceph_userkey
#    }

#    parameters = {
#      clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
#      fsName    = "cephfs"
#    }
#  }

#  resource "nomad_csi_volume" "plex" {

#    lifecycle {
#      prevent_destroy = true
#    }

#    plugin_id    = "cephfs"
#    volume_id    = "plex"
#    name         = "plex"

#    capability {
#      access_mode     = "single-node-writer"
#      attachment_mode = "file-system"
#    }

#    secrets = {
#      userID  = var.ceph_userid
#      userKey = var.ceph_userkey
#    }

#    parameters = {
#      clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
#      fsName    = "cephfs"
#    }
#  }

resource "nomad_csi_volume" "postgres" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "postgres"
  name         = "postgres"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "prowlarr" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "prowlarr"
  name         = "prowlarr"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "radarr" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "radarr"
  name         = "radarr"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}


resource "nomad_csi_volume" "sonarr" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "sonarr"
  name         = "sonarr"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}


resource "nomad_csi_volume" "jellyfin" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "jellyfin"
  name         = "jellyfin"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "sabnzbd" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "sabnzbd"
  name         = "sabnzbd"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "samba" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "samba"
  name         = "samba"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "transmission" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "transmission"
  name         = "transmission"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "unifi" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "unifi"
  name         = "unifi"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "wikijs" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephfs"
  volume_id    = "wikijs"
  name         = "wikijs"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

#  resource "nomad_csi_volume" "multimedia" {

#    lifecycle {
#      prevent_destroy = true
#    }

#    plugin_id = "cephfs"
#    volume_id = "multimedia"
#    name      = "multimedia"

#    capability {
#      access_mode     = "multi-node-multi-writer"
#      attachment_mode = "file-system"
#    }

#    secrets = {
#      userID  = var.ceph_userid
#      userKey = var.ceph_userkey
#    }

#    parameters = {
#      clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
#      fsName    = "cephfs"
#    }
#  }

resource "nomad_csi_volume" "certs" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id = "cephfs"
  volume_id = "certs"
  name      = "certs"


  capability {
    access_mode     = "multi-node-multi-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName    = "cephfs"
  }
}

resource "nomad_csi_volume" "mongo_init" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id = "cephfs"
  volume_id = "mongo_init"
  name      = "mongo_init"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

parameters = {
  clusterID = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
  fsName    = "cephfs"
  subvolumeName = "mongo_init"
  }
}