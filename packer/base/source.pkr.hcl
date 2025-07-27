source "proxmox-iso" "base" {
  
  proxmox_url = var.proxmox_url
  username    = var.proxmox_user
  password    = var.proxmox_password
  node        = var.proxmox_node
  
  insecure_skip_tls_verify = true

  vm_id                = 9000
  vm_name              = "base-tpl"
  template_description = "Base VM template"

  os              = "l26"
  cpu_type        = "host"
  sockets         = 1
  cores           = 2
  memory          = 2048
  machine         = "pc"
  scsi_controller = "virtio-scsi-single"
  qemu_agent      = true
  
  cloud_init              = true
  cloud_init_storage_pool = "rbd"

  vga {
    type = "std"
  }

  network_adapters {
    model    = "virtio"    
    bridge   = "vmbr2"
  }

  disks {
    disk_size         = "6G"
    storage_pool      = "rbd"
    type              = "scsi"
  }

<<<<<<< HEAD
  iso_file     = "local:iso/debian-12.10.0-amd64-netinst.iso"
  iso_checksum = "sha512:f4f7de1665cdcd00b2e526da6876f3e06a37da3549e9f880602f64407f602983a571c142eb0de0eacfc9c1d0f534e9339cdce04eb9daddc6ddfa8cf34853beed"
=======
  iso_file     = "local:iso/debian-12.9.0-amd64-netinst.iso"
  iso_checksum = "sha512:9ebe405c3404a005ce926e483bc6c6841b405c4d85e0c8a7b1707a7fe4957c617ae44bd807a57ec3e5c2d3e99f2101dfb26ef36b3720896906bdc3aaeec4cd80"
>>>>>>> 8fac54d12ac27512e70d92586abe70c4174c89b7
  unmount_iso  = true


  http_directory = "./http"
  http_port_min  = 8200
  http_port_max  = 8200
  boot_wait      = "10s"
  boot_command   = [
    "<esc><wait>auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"
    ]

  ssh_username = "root"
  ssh_password = "packer"
  ssh_timeout  = "20m"
  
}