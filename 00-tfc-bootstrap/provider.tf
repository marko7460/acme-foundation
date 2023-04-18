terraform {
  required_providers {
    tfe = {
      version = "~> 0.43.0"
    }
  }
  cloud {
    hostname = "app.terraform.io"
    workspaces {
      name = "00-tfc-workspaces"
    }
  }
}