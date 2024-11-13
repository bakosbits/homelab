source "proxmox-iso" "dns" {

  proxmox_url              = var.proxmox_api_url
  username                 = var.proxmox_api_user
  password                 = var.proxmox_api_password
  node                     = var.proxmox_node
  insecure_skip_tls_verify = true  

  vm_id                   = 9001
  vm_name                 = "coredns"
  template_description    = "Managed by terraform, built on ${formatdate("MM/DD/YYYY hh:mm:ss ZZZ", timestamp())}"

  os                      = "l26"
  cpu_type                = "host"
  sockets                 = 1
  cores                   = 2
  memory                  = 1024
  machine                 = "q35"
  bios                    = "seabios"
  scsi_controller         = "virtio-scsi-single"
  qemu_agent              = true

  cloud_init              = true
  cloud_init_storage_pool = var.storage_pool

  network_adapters {
    bridge = var.bridge
    model  = "virtio"
    tag    = var.vlan_tag
  }

  disks {
    disk_size         = "2G"
    format            = "raw"
    storage_pool      = var.storage_pool
    type              = "scsi"
  }

  iso_file     = var.iso_file
  unmount_iso  = true

  http_directory = "../http"
  http_port_min  = 8100
  http_port_max  = 8100
  boot_wait      = "10s"
  boot_command   = ["<esc><wait>auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]

  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout  = "20m"
}
