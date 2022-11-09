data "tfe_outputs" "host_project" {
  organization = var.tfc_organization
  workspace    = var.tfc_workspace_for_host_project
}

data "tfe_outputs" "admin-global" {
  organization = var.tfc_organization
  workspace    = "01-cloud-administration-global"
}

data "tfe_outputs" "shared-services" {
  organization = var.tfc_organization
  workspace    = "04-shared-services"
}

data "tfe_outputs" "org-policies" {
  organization = var.tfc_organization
  workspace    = "03-org-policies"
}

module "vpc" {
  for_each                               = var.shared_vpcs
  source                                 = "terraform-google-modules/network/google"
  version                                = "~> 6.0"
  project_id                             = data.tfe_outputs.host_project.values.projects[each.value.host_project].project_id
  network_name                           = each.key
  routing_mode                           = each.value.routing_mode
  subnets                                = each.value.subnets
  secondary_ranges                       = each.value.secondary_ranges
  routes                                 = each.value.routes
  delete_default_internet_gateway_routes = each.value.delete_default_internet_gateway_routes
  mtu                                    = each.value.mtu
}