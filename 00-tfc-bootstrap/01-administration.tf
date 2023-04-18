resource "tfe_workspace" "cloud-administration-global" {
  name                          = "01-cloud-administration-global"
  organization                  = var.tfc_organization
  project_id                    = tfe_project.project.id
  description                   = "Cloud Administration - Global. Use this for bootstraping, auditing, etc."
  tag_names                     = ["administration", "global"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.9"
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

resource "tfe_variable" "cloud-administration-global-gcp-service-account-email" {
  workspace_id = tfe_workspace.cloud-administration-global.id
  key          = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value        = google_service_account.tf-sa["tf-admin"].email
  category     = "env"
  description  = "The GCP service account email runs will use to authenticate."
}
