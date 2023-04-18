resource "tfe_workspace" "global-iam" {
  name                          = "02-global-iam"
  organization                  = var.tfc_organization
  project_id                    = tfe_project.project.id
  description                   = "Global IAM"
  tag_names                     = ["administration", "global"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.9"
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

resource "tfe_variable" "global-iam-gcp-service-account-email" {
  workspace_id = tfe_workspace.global-iam.id
  key          = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value        = google_service_account.tf-sa["tf-global-iam-sa"].email
  category     = "env"
  description  = "The GCP service account email runs will use to authenticate."
}