client {

  host_volume "hass" {
    path      = "/mnt/volumes/hass"
    read_only = false
  }

  host_volume "init_mongo" {
    path      = "/mnt/volumes/init_mongo"
    read_only = false
  }

  host_volume "media" {
    path      = "/mnt/media"
    read_only = false
  }

  host_volume "certs" {
    path      = "/mnt/volumes/certs"
    read_only = false
  }

}