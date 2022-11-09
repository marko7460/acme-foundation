data "tfe_oauth_client" "client" {
  organization = var.tfc_organization
  name         = var.github_oauth_client
}

resource "tfe_variable_set" "gcp-org-data" {
  name         = "GCP Org Data"
  description  = "GCP Org data necessary for project creations."
  organization = var.tfc_organization
}

resource "tfe_variable_set" "common-for-all" {
  name         = "Common for all"
  description  = "Common variables for all the workspaces."
  organization = var.tfc_organization
  global       = true
}

resource "tfe_variable_set" "workload-identity" {
  name         = "Workload Identity"
  description  = "Common variables for all the workspaces that need workload identity federation"
  organization = var.tfc_organization
  global       = false
}

resource "tfe_variable" "org_id" {
  key             = "org_id"
  value           = var.org_id
  category        = "terraform"
  description     = "Organization ID"
  variable_set_id = tfe_variable_set.gcp-org-data.id
}

resource "tfe_variable" "billing_account_id" {
  key             = "billing_account_id"
  value           = var.billing_account_id
  category        = "terraform"
  description     = "Billing Account ID"
  variable_set_id = tfe_variable_set.gcp-org-data.id
}

resource "tfe_variable" "tfc_organization" {
  key             = "tfc_organization"
  value           = var.tfc_organization
  category        = "terraform"
  description     = "TFC Cloud organization"
  variable_set_id = tfe_variable_set.common-for-all.id
}
