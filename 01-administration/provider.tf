data "tfe_outputs" "self" {
  workspace    = "01-cloud-administration-global"
  organization = var.tfc_organization
}

provider "google" {}
provider "google-beta" {}