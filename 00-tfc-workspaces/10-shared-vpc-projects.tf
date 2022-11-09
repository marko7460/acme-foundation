resource "tfe_workspace" "shared-vpc-project-dev" {
  name                          = "10-shared-vpc-projects-dev"
  organization                  = var.tfc_organization
  description                   = "Dev Shared VPC Project"
  tag_names                     = ["shared-vpc-project", "dev"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "10-shared-vpc-projects/envs/dev/"
  trigger_prefixes = [
    "10-shared-vpc-projects/modules/shared-vpc-project"
  ]
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "shared-vpc-project-dev" {
  variable_set_id = tfe_variable_set.gcp-org-data.id
  workspace_id    = tfe_workspace.shared-vpc-project-dev.id
}

resource "tfe_workspace_variable_set" "shared-vpc-project-wif-dev" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.shared-vpc-project-dev.id
}

resource "tfe_workspace" "shared-vpc-project-stg" {
  name                          = "10-shared-vpc-projects-stg"
  organization                  = var.tfc_organization
  description                   = "Stg Shared VPC Project"
  tag_names                     = ["shared-vpc-project", "stg"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "10-shared-vpc-projects/envs/stg/"
  trigger_prefixes = [
    "10-shared-vpc-projects/modules/shared-vpc-project"
  ]
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "shared-vpc-project-stg" {
  variable_set_id = tfe_variable_set.gcp-org-data.id
  workspace_id    = tfe_workspace.shared-vpc-project-stg.id
}

resource "tfe_workspace_variable_set" "shared-vpc-project-wif-stg" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.shared-vpc-project-stg.id
}

resource "tfe_workspace" "shared-vpc-project-prd" {
  name                          = "10-shared-vpc-projects-prd"
  organization                  = var.tfc_organization
  description                   = "Prd Shared VPC Project"
  tag_names                     = ["shared-vpc-project", "prd"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "10-shared-vpc-projects/envs/prd/"
  trigger_prefixes = [
    "10-shared-vpc-projects/modules/shared-vpc-project"
  ]
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_workspace_variable_set" "shared-vpc-project-prd" {
  variable_set_id = tfe_variable_set.gcp-org-data.id
  workspace_id    = tfe_workspace.shared-vpc-project-prd.id
}

resource "tfe_workspace_variable_set" "shared-vpc-project-wif-prd" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.shared-vpc-project-prd.id
}