terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "2.21.0"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = "2.4.0"
    }
  }
}

provider "nomad" {
  address = var.nomad_url
  secret_id = var.secret_id  
}

provider "consul" {
  address = var.consul_url
}

