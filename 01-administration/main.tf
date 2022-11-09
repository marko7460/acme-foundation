data "tfe_outputs" "workspaces" {
  workspace    = "00-tfc-workspaces"
  organization = var.tfc_organization
}
