resource "tfe_workspace" "shared-services" {
  name                          = "04-shared-services"
  organization                  = var.tfc_organization
  description                   = "Common services shared amongst all the environments"
  tag_names                     = ["common", "global", "shared"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "04-shared-services"
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "shared-services" {
  variable_set_id = tfe_variable_set.gcp-org-data.id
  workspace_id    = tfe_workspace.shared-services.id
}

resource "tfe_workspace_variable_set" "shared-services-wif" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.shared-services.id
}