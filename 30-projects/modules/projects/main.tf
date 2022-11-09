data "tfe_outputs" "admin-global" {
  organization = var.tfc_organization
  workspace    = "01-cloud-administration-global"
}

data "tfe_outputs" "host_project" {
  organization = var.tfc_organization
  workspace    = var.tfc_host_project_workspace
}

data "tfe_outputs" "host_project_networking" {
  organization = var.tfc_organization
  workspace    = var.tfc_host_networking_workspace
}

data "tfe_outputs" "org-policies" {
  organization = var.tfc_organization
  workspace    = "03-org-policies"
}

module "projects" {
  for_each             = var.projects
  source               = "terraform-google-modules/project-factory/google"
  version              = "~> 14.1"
  name                 = each.key
  folder_id            = data.tfe_outputs.admin-global.values.folders[var.folder].folder_id
  random_project_id    = true
  org_id               = var.org_id
  billing_account      = var.billing_account_id
  activate_apis        = each.value.activate_apis
  labels               = each.value.labels
  svpc_host_project_id = each.value.svpc_host_project != "" ? data.tfe_outputs.host_project.values.projects[each.value.svpc_host_project].project_id : each.value.svpc_host_project
  shared_vpc_subnets = [
    for subnet in each.value.shared_vpc_subnets :
    data.tfe_outputs.host_project_networking.values.shared_vpc_networks[subnet.network].subnets["${subnet.region}/${subnet.subnet_name}"].id
  ]
  default_service_account = "deprivilege"

  vpc_service_control_attach_enabled = each.value.vpc_service_control_attach_enabled
  vpc_service_control_perimeter_name = each.value.vpc_service_control_attach_enabled ? "accessPolicies/${data.tfe_outputs.org-policies.values.access_context_manager_policy_ids[each.value.access_context_manager_policy_name]}/servicePerimeters/${data.tfe_outputs.host_project_networking.values.vpc_service_perimeter[each.value.vpc_service_control_name].perimeter_name}" : null
  vpc_service_control_sleep_duration = each.value.vpc_service_control_sleep_duration
}