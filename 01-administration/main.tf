data "tfe_outputs" "bootstrap" {
  workspace    = "00-tfc-bootstrap"
  organization = var.tfc_organization
}
