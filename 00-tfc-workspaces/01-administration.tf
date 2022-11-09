resource "tfe_workspace" "cloud-administration-global" {
  name                          = "01-cloud-administration-global"
  organization                  = var.tfc_organization
  description                   = "Cloud Administration - Global. Use this for bootstraping, auditing, etc."
  tag_names                     = ["administration", "global"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "01-administration"
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "cloud-administration-global-gcp-org-data" {
  variable_set_id = tfe_variable_set.gcp-org-data.id
  workspace_id    = tfe_workspace.cloud-administration-global.id
}

resource "tfe_workspace_variable_set" "cloud-administration-global-wif" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.cloud-administration-global.id
}

data "tfe_organization" "tfc-org" {
  name = var.tfc_organization
}

resource "tfe_variable" "cloud-administration-global-tfc-organization-id" {
  category     = "terraform"
  key          = "tfc_organization_id"
  value        = data.tfe_organization.tfc-org.id
  workspace_id = tfe_workspace.cloud-administration-global.id
}

resource "tfe_variable" "cloud-administration-global-use-google-oath_token" {
  category     = "terraform"
  key          = "use_google_oath_token"
  value        = true
  workspace_id = tfe_workspace.cloud-administration-global.id
}