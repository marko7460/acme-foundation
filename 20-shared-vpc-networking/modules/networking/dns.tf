resource "google_dns_policy" "default_policy" {
  for_each                  = var.shared_vpcs
  project                   = module.vpc[each.key].project_id
  name                      = "dp-${each.key}-shared-base-default-policy"
  enable_inbound_forwarding = each.value.dns_enable_inbound_forwarding
  enable_logging            = each.value.dns_enable_logging
  networks {
    network_url = module.vpc[each.key].network_self_link
  }
}

/******************************************
 Creates DNS Peering to DNS HUB
*****************************************/

module "peering_zone" {
  for_each    = var.shared_vpcs
  source      = "terraform-google-modules/cloud-dns/google"
  version     = "~> 4.1"
  project_id  = module.vpc[each.key].project_id
  type        = "peering"
  name        = "dz-${each.key}-shared-to-dns-hub"
  domain      = each.value.domain
  description = "Private DNS peering zone."

  private_visibility_config_networks = [
    module.vpc[each.key].network_self_link
  ]
  target_network = data.tfe_outputs.shared-services.values.vpcs["common-services/dns-hub"].network_self_link
}
