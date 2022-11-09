resource "tfe_workspace" "org-policies" {
  name                          = "03-org-policies"
  organization                  = var.tfc_organization
  description                   = "Organization Policies"
  tag_names                     = ["administration", "global"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "03-org-policies"
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_variable" "org-policies-org-id" {
  category     = "terraform"
  key          = "org_id"
  value        = var.org_id
  description  = "GCP Organization ID"
  workspace_id = tfe_workspace.org-policies.id
}

resource "tfe_workspace_variable_set" "org-policies-wif" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.org-policies.id
}