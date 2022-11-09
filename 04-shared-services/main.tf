data "tfe_outputs" "admin-global" {
  organization = var.tfc_organization
  workspace    = "01-cloud-administration-global"
}

module "projects" {
  for_each                       = var.projects
  source                         = "terraform-google-modules/project-factory/google"
  version                        = "~> 14.1"
  name                           = each.key
  folder_id                      = data.tfe_outputs.admin-global.values.folders["shared"].folder_id
  random_project_id              = true
  enable_shared_vpc_host_project = each.value.enable_shared_vpc_host_project
  org_id                         = var.org_id
  billing_account                = var.billing_account_id
  activate_apis                  = each.value.activate_apis
  labels                         = each.value.labels
  default_service_account        = "deprivilege"
}

locals {
  networks_tmp = flatten([
    for project, prj_conf in var.projects : [
      for vpc, vpc_conf in prj_conf.vpcs :
      {
        project = project
        vpc     = vpc
        conf    = vpc_conf
      }
    ]
  ])
  networks = { for network in local.networks_tmp : "${network.project}/${network.vpc}" => network }
}

module "vpc" {
  for_each                               = local.networks
  source                                 = "terraform-google-modules/network/google"
  version                                = "~> 6.0"
  project_id                             = module.projects[each.value.project].project_id
  network_name                           = each.value.vpc
  routing_mode                           = each.value.conf.routing_mode
  subnets                                = each.value.conf.subnets
  secondary_ranges                       = each.value.conf.secondary_ranges
  routes                                 = each.value.conf.routes
  delete_default_internet_gateway_routes = each.value.conf.delete_default_internet_gateway_routes
  mtu                                    = each.value.conf.mtu
  depends_on                             = [module.projects]
}