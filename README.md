# My homelab

This repository holds the configuration for my homelab. I'm using [Nomad](https://nomadproject.io) and [Consul](https://www.consul.io/) for orchestration and service discovery. [Packer](https://packer.io) is slinging virtual images while [Terraform](https://www.terraform.io) is helping to deploy and manage state. 

My lab runs on a 3 node [Proxmox](https://www.proxmox.com/en/) cluster. Terraform deploys 3 server nodes and 3 client nodes that makeup the cluster. It also manages a services node (DNS, etc) as well as several hosts that makeup a logging infrastructure seperate from the Nomad cluster.  

## Workloads

[Traefik](https://traefik.io) is being used as a reverse proxy. My network hardware is all [Unifi](https://ui.com) equipment and I make extensive use of [Home Assistant](https://home-assistant.io). 

A full list of workloads [here](terraform/nomad/jobs/).

## Storage

Update: As of 10/6/2024 I have migrated away from Gluster and I'm now using Ceph as my backing store.

My lab currently takes advantage of Nomad host volumes. I like the additional safeguard provided through volume awareness.  The host volumes are made available via Gluster which is in turn backed by ZFS. This setup isn't as flexible as docker volumes or a CSI plugin. It's simple. It's fast. It's reliable. It's quick to refactor if I move to CSI plugins for storage. I'll evaluate my CSI plugin options if/when I migrate to [Ceph](https://ceph.io)
