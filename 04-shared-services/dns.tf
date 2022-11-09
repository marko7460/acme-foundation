//Centralized DNS
module "dns-private-zone" {
  for_each   = var.private_dns
  source     = "terraform-google-modules/cloud-dns/google"
  version    = "4.1.0"
  project_id = module.projects[each.value.project].project_id
  type       = "private"
  name       = each.key
  domain     = each.value.domain
  private_visibility_config_networks = [
    module.vpc["${each.value.project}/${each.value.vpc}"].network_self_link
  ]
  recordsets = each.value.recordsets
}