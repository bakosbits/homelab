terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "2.21.0"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = "2.3.1"
    }
  }
}

provider "nomad" {
  address = var.nomad_server
}

provider "consul" {
  address = var.consul_server
}

