### cephrbd ###

resource "nomad_csi_volume" "arcade_config" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "arcade_config"
  name         = "arcade_config"
  capacity_min = "1G"
  capacity_max = "5G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "arcade_data" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "arcade_data"
  name         = "arcade_data"
  capacity_min = "1G"
  capacity_max = "100G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "docker-registry" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "docker-registry"
  name         = "docker-registry"
  capacity_min = "1G"
  capacity_max = "5G"

  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "vaultwarden" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "vaultwarden"
  name         = "vaultwarden"
  capacity_min = "1G"
  capacity_max = "5G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "flaresolverr" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "flaresolverr"
  name         = "flaresolverr"
  capacity_min = "1G"
  capacity_max = "5G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "grafana" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "grafana"
  name         = "grafana"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "influxdb_config" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "influxdb_config"
  name         = "influxdb_config"
  capacity_min = "1G"
  capacity_max = "5G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "influxdb_data" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "influxdb_data"
  name         = "influxdb_data"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "mongodb6" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "mongodb6"
  name         = "mongodb6"
  capacity_min = "1G"
  capacity_max = "25G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "mongodb7" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "mongodb7"
  name         = "mongodb7"
  capacity_min = "1G"
  capacity_max = "25G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "loki" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "loki"
  name         = "loki"
  capacity_min = "1G"
  capacity_max = "25G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "plex" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "plex"
  name         = "plex"
  capacity_min = "5G"
  capacity_max = "25G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "postgres" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "postgres"
  name         = "postgres"
  capacity_min = "1G"
  capacity_max = "1000G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "prowlarr" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "prowlarr"
  name         = "prowlarr"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "radarr" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "radarr"
  name         = "radarr"
  capacity_min = "2G"
  capacity_max = "25G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}


resource "nomad_csi_volume" "sonarr" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "sonarr"
  name         = "sonarr"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}


resource "nomad_csi_volume" "jellyfin" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "jellyfin"
  name         = "jellyfin"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "sabnzbd" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "sabnzbd"
  name         = "sabnzdb"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "samba" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "samba"
  name         = "samba"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "transmission" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "transmission"
  name         = "transmission"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "unifi" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "unifi"
  name         = "unifi"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

resource "nomad_csi_volume" "wikijs" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id    = "cephrbd"
  volume_id    = "wikijs"
  name         = "wikijs"
  capacity_min = "1G"
  capacity_max = "10G"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    userID  = var.ceph_userid
    userKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    pool          = "rbd"
    imageFeatures = "layering"
    mkfsOptions   = "-t ext4"
  }
}

### cephfs ###

resource "nomad_csi_volume" "media" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id = "cephfs"
  volume_id = "media"
  name      = "media"

  capability {
    access_mode     = "multi-node-multi-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    adminID  = var.ceph_userid
    adminKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName        = "cephfs"
    pool          = "cephfs_data"
    imageFeatures = "layering"
  }
}

resource "nomad_csi_volume" "certs" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id = "cephfs"
  volume_id = "certs"
  name      = "certs"


  capability {
    access_mode     = "multi-node-reader-only"
    attachment_mode = "file-system"
  }

  secrets = {
    adminID  = var.ceph_userid
    adminKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName        = "cephfs"
    pool          = "cephfs_data"
    imageFeatures = "layering"
  }
}

resource "nomad_csi_volume" "hass" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id = "cephfs"
  volume_id = "hass"
  name      = "hass"


  capability {
    access_mode     = "single-node-writer"
    attachment_mode = "file-system"
  }

  secrets = {
    adminID  = var.ceph_userid
    adminKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName        = "cephfs"
    pool          = "cephfs_data"
    imageFeatures = "layering"
  }
}

resource "nomad_csi_volume" "init-mongo" {

  lifecycle {
    prevent_destroy = true
  }

  plugin_id = "cephfs"
  volume_id = "init-mongo"
  name      = "init-mongo"


  capability {
    access_mode     = "multi-node-reader-only"
    attachment_mode = "file-system"
  }

  secrets = {
    adminID  = var.ceph_userid
    adminKey = var.ceph_userkey
  }

  parameters = {
    clusterID     = "820b0f5c-cee3-40a7-b5d5-0aada0355612"
    fsName        = "cephfs"
    pool          = "cephfs_data"
    imageFeatures = "layering"
  }
}
