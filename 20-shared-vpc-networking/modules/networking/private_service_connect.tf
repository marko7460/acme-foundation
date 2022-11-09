/***************************************************************
  Configure Service Networking for Cloud SQL & future services.
 **************************************************************/

resource "google_compute_global_address" "private_service_access_address" {
  for_each      = var.shared_vpcs
  name          = "ga-${each.key}-vpc-peering-internal"
  project       = module.vpc[each.key].project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = element(split("/", each.value.private_service_cidr), 0)
  prefix_length = element(split("/", each.value.private_service_cidr), 1)
  network       = module.vpc[each.key].network_self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  for_each                = var.shared_vpcs
  network                 = module.vpc[each.key].network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_service_access_address[each.key].name]
}

module "private_service_connect" {
  for_each                   = var.shared_vpcs
  source                     = "terraform-google-modules/network/google//modules/private-service-connect"
  version                    = "~> 6.0"
  project_id                 = module.vpc[each.key].project_id
  dns_code                   = "dz-${each.key}-shared-base"
  network_self_link          = module.vpc[each.key].network_self_link
  private_service_connect_ip = each.value.private_service_connect_ip
  forwarding_rule_target     = "all-apis"
}