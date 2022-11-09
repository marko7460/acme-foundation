module "tfe_oidc" {
  # TODO: Update the source URL to point to proper version of the module
  source                             = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//blueprints/cloud-operations/terraform-enterprise-wif/tfc-workflow-using-wif/tfc-oidc"
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  impersonate_service_account_email  = data.tfe_outputs.admin-global.values.service_accounts[var.terraform_service_account].email
}

provider "google" {
  credentials = module.tfe_oidc.credentials
}

provider "google-beta" {
  credentials = module.tfe_oidc.credentials
}