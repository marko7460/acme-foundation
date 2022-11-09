resource "google_compute_firewall" "deny_all_egress" {
  for_each  = var.shared_vpcs
  name      = "fw-shared-base-65530-e-d-all-all"
  network   = module.vpc[each.key].network_name
  project   = module.vpc[each.key].project_id
  direction = "EGRESS"
  priority  = 65530

  dynamic "log_config" {
    for_each = each.value.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  deny {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "allow_private_api_egress" {
  for_each  = var.shared_vpcs
  name      = "fw-shared-base-65530-e-a-allow-google-apis-all-tcp-443"
  network   = module.vpc[each.key].network_name
  project   = module.vpc[each.key].project_id
  direction = "EGRESS"
  priority  = 65530

  dynamic "log_config" {
    for_each = each.value.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  destination_ranges = [module.private_service_connect[each.key].private_service_connect_ip]

  target_tags = ["allow-google-apis"]
}


resource "google_compute_firewall" "allow_all_egress" {
  for_each  = { for k, v in var.shared_vpcs : k => v if length(v.allow_all_egress_ranges) > 0 }
  name      = "fw-${each.key}-shared-base-1000-e-a-all"
  network   = module.vpc[each.key].network_name
  project   = module.vpc[each.key].project_id
  direction = "EGRESS"
  priority  = 1000

  dynamic "log_config" {
    for_each = each.value.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  allow {
    protocol = "all"
  }

  destination_ranges = each.value.allow_all_egress_ranges
}

resource "google_compute_firewall" "allow_all_ingress" {
  for_each  = { for k, v in var.shared_vpcs : k => v if length(v.allow_all_ingress_ranges) > 0 }
  name      = "fw-${each.key}-shared-base-1000-i-a-all"
  network   = module.vpc[each.key].network_name
  project   = module.vpc[each.key].project_id
  direction = "INGRESS"
  priority  = 1000

  dynamic "log_config" {
    for_each = each.value.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  allow {
    protocol = "all"
  }

  source_ranges = each.value.allow_all_ingress_ranges
}