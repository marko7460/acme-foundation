resource "tfe_workspace" "shared-vpc-networking-dev" {
  name                          = "20-shared-vpc-networking-dev"
  organization                  = var.tfc_organization
  description                   = "Dev Shared VPC Networking"
  tag_names                     = ["shared-vpc-networking", "dev"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "20-shared-vpc-networking/envs/dev/"
  trigger_prefixes = [
    "20-shared-vpc-networking/modules/networking"
  ]
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "shared-vpc-networking-wif-dev" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.shared-vpc-networking-dev.id
}

resource "tfe_workspace" "shared-vpc-networking-stg" {
  name                          = "20-shared-vpc-networking-stg"
  organization                  = var.tfc_organization
  description                   = "Stg Shared VPC Networking"
  tag_names                     = ["shared-vpc-networking", "stg"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "20-shared-vpc-networking/envs/stg/"
  trigger_prefixes = [
    "20-shared-vpc-networking/modules/networking"
  ]
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "shared-vpc-networking-wif-stg" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.shared-vpc-networking-stg.id
}

resource "tfe_workspace" "shared-vpc-networking-prd" {
  name                          = "20-shared-vpc-networking-prd"
  organization                  = var.tfc_organization
  description                   = "Prd Shared VPC Networking"
  tag_names                     = ["shared-vpc-networking", "prd"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "20-shared-vpc-networking/envs/prd/"
  trigger_prefixes = [
    "20-shared-vpc-networking/modules/networking"
  ]
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "shared-vpc-networking-wif-prd" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.shared-vpc-networking-prd.id
}