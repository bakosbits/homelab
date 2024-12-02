source "proxmox-iso" "nomad-client" {
  proxmox_url              = var.proxmox_api_url
  username                 = var.proxmox_api_user
  password                 = var.proxmox_api_password
  node                     = var.proxmox_node
  
  vm_id                   = 9002
  vm_name                 = "nomad-client"
  template_description    = "Managed by terraform, built on ${formatdate("MM/DD/YYYY hh:mm:ss ZZZ", timestamp())}"

  os                      = "l26"
  cpu_type                = "host"
  sockets                 = 1
  cores                   = 4
  memory                  = 10240
  machine                 = "q35"
  bios                    = "seabios"
  scsi_controller         = "virtio-scsi-single"
  qemu_agent              = true
  cloud_init              = true
  cloud_init_storage_pool = var.storage_pool

  network_adapters {
    bridge = var.bridge
    model  = "virtio"
    vlan_tag    = var.vlan_tag    
  }

  disks {
    disk_size         = "4G"
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