data "tfe_outputs" "self" {
  count        = !var.use_google_oath_token ? 1 : 0
  workspace    = "01-cloud-administration-global"
  organization = var.tfc_organization
}

module "tfe_oidc" {
  # TODO: Update the source URL to point to proper version of the module
  source                             = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//blueprints/cloud-operations/terraform-enterprise-wif/tfc-workflow-using-wif/tfc-oidc"
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  impersonate_service_account_email  = var.use_google_oath_token ? "" : data.tfe_outputs.self.0.values.service_account_self
}

provider "google" {
  credentials = !var.use_google_oath_token ? module.tfe_oidc.credentials : null
}

provider "google-beta" {
  credentials = !var.use_google_oath_token ? module.tfe_oidc.credentials : null
}