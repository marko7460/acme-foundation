resource "tfe_workspace" "global-iam" {
  name                          = "02-global-iam"
  organization                  = var.tfc_organization
  description                   = "Global IAM"
  tag_names                     = ["administration", "global"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "02-global-iam"
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_variable" "global-iam-org-id" {
  key          = "org_id"
  value        = var.org_id
  category     = "terraform"
  description  = "GCP Organization ID"
  workspace_id = tfe_workspace.global-iam.id
}

resource "tfe_workspace_variable_set" "global-iam-wif" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.global-iam.id
}