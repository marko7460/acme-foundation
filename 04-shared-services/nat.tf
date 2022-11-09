locals {
  nat_routers_tmp = flatten([
    for project, prj_conf in var.projects : [
      for vpc, vpc_conf in prj_conf.vpcs : [
        for nat, nat_conf in vpc_conf.nats : {
          project = project,
          vpc     = vpc,
          nat     = nat,
          region  = nat_conf.region,
          conf    = nat_conf,
        }
      ]
    ]
  ])
  nat_routers = { for nat_router in local.nat_routers_tmp : "${nat_router.project}-${nat_router.vpc}-${nat_router.nat}-${nat_router.region}" => nat_router }
}

resource "google_compute_router" "router" {
  for_each    = local.nat_routers
  name        = each.key
  network     = module.vpc["${each.value.project}/${each.value.vpc}"].network
  region      = each.value.region
  project     = module.vpc["${each.value.project}/${each.value.vpc}"].project_id
  description = "Router for ${each.value.vpc} in ${each.value.region} for ${each.value.nat}"
  depends_on  = [module.vpc]
}

resource "google_compute_router_nat" "nats" {
  for_each = local.nat_routers

  name                               = each.value.nat
  project                            = module.vpc["${each.value.project}/${each.value.vpc}"].project_id
  router                             = google_compute_router.router[each.key].name
  region                             = google_compute_router.router[each.key].region
  nat_ip_allocate_option             = lookup(each.value.conf, "nat_ip_allocate_option", length(lookup(each.value, "nat_ips", [])) > 0 ? "MANUAL_ONLY" : "AUTO_ONLY")
  source_subnetwork_ip_ranges_to_nat = lookup(each.value.conf, "source_subnetwork_ip_ranges_to_nat", "ALL_SUBNETWORKS_ALL_IP_RANGES")

  nat_ips                             = lookup(each.value.conf, "nat_ips", null)
  min_ports_per_vm                    = lookup(each.value.conf, "min_ports_per_vm", null)
  max_ports_per_vm                    = lookup(each.value.conf, "max_ports_per_vm", null)
  udp_idle_timeout_sec                = lookup(each.value.conf, "udp_idle_timeout_sec", null)
  icmp_idle_timeout_sec               = lookup(each.value.conf, "icmp_idle_timeout_sec", null)
  tcp_established_idle_timeout_sec    = lookup(each.value.conf, "tcp_established_idle_timeout_sec", null)
  tcp_transitory_idle_timeout_sec     = lookup(each.value.conf, "tcp_transitory_idle_timeout_sec", null)
  enable_endpoint_independent_mapping = lookup(each.value.conf, "enable_endpoint_independent_mapping", null)
  enable_dynamic_port_allocation      = lookup(each.value.conf, "enable_dynamic_port_allocation", null)

  log_config {
    enable = true
    filter = lookup(lookup(each.value.conf, "log_config", {}), "filter", "ALL")
  }

  dynamic "subnetwork" {
    for_each = lookup(each.value.conf, "subnetworks", [])
    content {
      name                     = "projects/${module.vpc[format("%s/%s", each.value.project, each.value.vpc)].project_id}/regions/${each.value.region}/subnetworks/${subnetwork.value.name}"
      source_ip_ranges_to_nat  = subnetwork.value.source_ip_ranges_to_nat
      secondary_ip_range_names = lookup(subnetwork.value, "secondary_ip_range_names", null)
    }
  }
  depends_on = [module.vpc]
}