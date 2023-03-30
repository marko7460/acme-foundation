data "tfe_outputs" "bootstrap" {
  organization = var.tfc_organization
  workspace    = "00-tfc-bootstrap"
}

module "projects" {
  for_each                       = var.projects
  source                         = "terraform-google-modules/project-factory/google"
  version                        = "~> 14.1"
  name                           = each.key
  folder_id                      = data.tfe_outputs.bootstrap.values.folders[each.value.folder].folder_id
  random_project_id              = true
  enable_shared_vpc_host_project = true
  org_id                         = var.org_id
  billing_account                = var.billing_account_id
  activate_apis                  = each.value.activate_apis
  labels                         = each.value.labels
  default_service_account        = "deprivilege"
}
