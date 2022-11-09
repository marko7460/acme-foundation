resource "google_iam_workload_identity_pool" "tfe-pool" {
  project                   = module.admin_project.project_id
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = "TFE Pool"
  description               = "Identity pool for Terraform Enterprise OIDC integration"
}

resource "google_iam_workload_identity_pool_provider" "tfe-pool-provider" {
  project                            = module.admin_project.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.tfe-pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "tfe-pool"
  display_name                       = "TFE Pool Provider"
  description                        = "OIDC identity pool provider for TFE Integration"
  # Use condition to make sure only token generated for a specific TFE Org can be used across org workspaces
  attribute_condition = "attribute.terraform_organization_id == \"${var.tfc_organization_id}\""
  attribute_mapping = {
    "google.subject"                        = "assertion.sub"
    "attribute.aud"                         = "assertion.aud"
    "attribute.terraform_run_phase"         = "assertion.terraform_run_phase"
    "attribute.terraform_workspace_id"      = "assertion.terraform_workspace_id"
    "attribute.terraform_workspace_name"    = "assertion.terraform_workspace_name"
    "attribute.terraform_organization_id"   = "assertion.terraform_organization_id"
    "attribute.terraform_organization_name" = "assertion.terraform_organization_name"
    "attribute.terraform_run_id"            = "assertion.terraform_run_id"
    "attribute.terraform_full_workspace"    = "assertion.terraform_full_workspace"
  }
  oidc {
    # Should be different if self hosted TFE instance is used
    issuer_uri = var.issuer_uri
  }
}