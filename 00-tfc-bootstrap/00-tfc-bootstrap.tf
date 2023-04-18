resource "tfe_workspace_variable_set" "bootstrap-wif" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = data.tfe_workspace.bootstrap.id
}

resource "tfe_variable" "bootstrap-gcp-service-account-email" {
  workspace_id = data.tfe_workspace.bootstrap.id
  key          = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value        = google_service_account.tf-bootstrap-self.email
  category     = "env"
  description  = "The GCP service account email runs will use to authenticate."
}