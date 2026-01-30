####################################################################
# Cloud-init config for each host and role: consul, nomad, coredns #
####################################################################
resource "proxmox_virtual_environment_file" "role_config" {
  for_each     = local.all_nodes
  node_name    = var.pve_nodes[0]
  datastore_id = var.config_storage
  content_type = "snippets"

  source_raw {
    file_name = "${each.value.name}-setup.yaml"
    data = <<-EOF
#cloud-config
hostname: ${each.value.name}
manage_etc_hosts: true
users:
  - default # Adds the default user for the OS (optional)
  - name: ${var.ciuser}
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh_authorized_keys:
      - ${trimspace(var.sshkeys)}
# Optional: Set the password for console access if SSH fails
chpasswd:
  list: |
    ${var.ciuser}:${var.cipassword}
  expire: False
package_update: true
write_files:
  # Role-specific config (consul, nomad, coredns)
${local.role_mapper[each.value.role]}
runcmd:
  - echo "nameserver ${each.value.nameserver}" | sudo tee /etc/resolv.conf
  - systemctl daemon-reload
  - systemctl enable --now consul
  - [ systemctl, enable, --now, ${each.value.role == "dns" ? "coredns" : "nomad"} ]
  - echo "done" > /tmp/cloud-config.done
EOF
  }
}

############################################
# Local vars to support the resource above #
############################################
locals {
  # --- Template Injections ---
  dns_zone_file = templatefile("${path.module}/templates/dns_zone_file.tpl", {
    domain     = var.domain
    dns_ip     = local.dns_ip[0]
    worker_ips = local.worker_ips
  })

  corefile = templatefile("${path.module}/templates/corefile.tpl", {
    domain     = var.domain
    nameserver = var.nameserver
  })

  coredns_service_hcl = file("${path.module}/templates/coredns_service.tpl")
  nomad_manager_hcl   = file("${path.module}/templates/nomad_manager.tpl")
  nomad_worker_hcl    = file("${path.module}/templates/nomad_worker.tpl")
  retry_join_json     = jsonencode([for m in local.manager_nodes : m.ip])
  
  consul_manager_hcl  = templatefile("${path.module}/templates/consul_manager.tpl", { 
    retry_join_json   = local.retry_join_json
  })

  consul_worker_hcl   = templatefile("${path.module}/templates/consul_worker.tpl", {
    retry_join_json   = local.retry_join_json
  })

  # --- The Role Mapper ---
  role_mapper = {
    dns = <<-EOT
  - path: /etc/consul.d/coredns_service.hcl
    content: |
      ${indent(6, local.coredns_service_hcl)}
  - path: /etc/consul.d/consul.hcl
    content: |
      ${indent(6, local.consul_manager_hcl)}
  - path: /etc/coredns/corefile
    content: |
      ${indent(6, local.corefile)}
  - path: /etc/coredns/zones/db.${var.domain}
    content: |
      ${indent(6, local.dns_zone_file)}
EOT

    manager = <<-EOT
  - path: /etc/consul.d/consul.hcl
    content: |
      ${indent(6, local.consul_manager_hcl)}
  - path: /etc/nomad.d/nomad.hcl
    content: |
      ${indent(6, local.nomad_manager_hcl)}
EOT

    worker = <<-EOT
  - path: /etc/consul.d/consul.hcl
    content: |
      ${indent(6, local.consul_worker_hcl)}
  - path: /etc/nomad.d/nomad.hcl
    content: |
      ${indent(6, local.nomad_worker_hcl)}
EOT
  }
}