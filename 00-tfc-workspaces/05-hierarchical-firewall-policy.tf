resource "tfe_workspace" "hierarchical-firewall-policy" {
  name                          = "05-hierarchical-firewall-policy"
  organization                  = var.tfc_organization
  description                   = "Hierarchical Firewall Policy"
  tag_names                     = ["common", "global", "shared", "firewall"]
  allow_destroy_plan            = true
  global_remote_state           = true
  terraform_version             = "1.3.3"
  structured_run_output_enabled = true
  queue_all_runs                = false
  working_directory             = "05-hierarchical-firewall-policy"
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_variable" "hierarchical-firewall-policy-org_id" {
  key          = "org_id"
  value        = var.org_id
  category     = "terraform"
  description  = "GCP Organization ID"
  sensitive    = true
  workspace_id = tfe_workspace.hierarchical-firewall-policy.id
}

resource "tfe_workspace_variable_set" "hierarchical-firewall-policy-wif" {
  variable_set_id = tfe_variable_set.workload-identity.id
  workspace_id    = tfe_workspace.hierarchical-firewall-policy.id
}