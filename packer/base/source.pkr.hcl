source "proxmox-iso" "base" {
  proxmox_url = var.proxmox_url
  username    = var.proxmox_user
  password    = var.proxmox_password
  node        = var.proxmox_node
  
  insecure_skip_tls_verify = true
  
  vm_id                = 9000
  vm_name              = "base-tpl"
  template_description = "Base template - Debian 12"

  os              = "l26"
  cpu_type        = "host"
  sockets         = 1
  cores           = 1
  memory          = 1024
  machine         = "q35"
  scsi_controller = "virtio-scsi-single"
  qemu_agent      = true
  
  cloud_init              = true
  cloud_init_storage_pool = "rbd"

  network_adapters {
    model    = "virtio"    
    bridge   = "vmbr2"
    vlan_tag = "20"
  }

  vga {
    memory  = 8
    type    = "std"
  }

  disks {
    disk_size         = "6G"
    storage_pool      = "rbd"
    type              = "scsi"
  }

  iso_file     = "local:iso/debian-12.8.0-amd64-netinst.iso"
  iso_checksum = "sha512:f4f7de1665cdcd00b2e526da6876f3e06a37da3549e9f880602f64407f602983a571c142eb0de0eacfc9c1d0f534e9339cdce04eb9daddc6ddfa8cf34853beed"
  unmount_iso  = true


  http_directory = "${path.root}/http"
  http_port_min  = 8100
  http_port_max  = 8100
  boot_wait      = "10s"
  boot_command   = ["<esc><wait>auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]

  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout  = "20m"
}