variable "tfc_organization" {
  description = "The TFC organization name"
}

variable "workload_identity_pool_provider_id" {
  description = "GCP workload identity pool provider ID. Set this value in your workspace after the initial deployement"
  type        = string
}

variable "terraform_service_account" {
  description = "The service account id used by Terraform Cloud to access GCP. This is set in 01-administration/terraform.tfvars "
}

variable "billing_account_id" {
  description = "Billing Account ID"
}

variable "org_id" {
  description = "Organization ID"
}

variable "projects" {
  description = "Map of projects to create. Key is the name of the project"
  type = map(object({
    labels                         = optional(map(string), {})
    enable_shared_vpc_host_project = optional(bool, false)
    activate_apis = optional(list(string), [
      "compute.googleapis.com",
      "container.googleapis.com",
      "dataproc.googleapis.com",
      "dataflow.googleapis.com",
      "composer.googleapis.com",
      "vpcaccess.googleapis.com",
      "dns.googleapis.com",
    ])
    vpcs = map(object({
      subnets                                = list(map(string))
      routing_mode                           = optional(string, "GLOBAL")
      secondary_ranges                       = optional(map(list(object({ range_name = string, ip_cidr_range = string }))), {})
      routes                                 = optional(list(map(string)), [])
      delete_default_internet_gateway_routes = optional(bool, false)
      mtu                                    = optional(number, 0)
      firewall_enable_logging                = optional(bool, false)

      # Type: list(object), with fields:
      # - name (string, required): Name of the NAT.
      # - nat_ip_allocate_option (string, optional): How external IPs should be allocated for this NAT. Defaults to MANUAL_ONLY if nat_ips are set, else AUTO_ONLY.
      # - source_subnetwork_ip_ranges_to_nat (string, optional): How NAT should be configured per Subnetwork. Defaults to ALL_SUBNETWORKS_ALL_IP_RANGES.
      # - nat_ips (list(number), optional): Self-links of NAT IPs.
      # - min_ports_per_vm (number, optional): Minimum number of ports allocated to a VM from this NAT.
      # - max_ports_per_vm (number, optional): Maximum number of ports allocated to a VM from this NAT. This field can only be set when enableDynamicPortAllocation is enabled.
      # - udp_idle_timeout_sec (number, optional): Timeout (in seconds) for UDP connections. Defaults to 30s if not set.
      # - icmp_idle_timeout_sec (number, optional): Timeout (in seconds) for ICMP connections. Defaults to 30s if not set.
      # - tcp_established_idle_timeout_sec (number, optional): Timeout (in seconds) for TCP established connections. Defaults to 1200s if not set.
      # - tcp_transitory_idle_timeout_sec (number, optional): Timeout (in seconds) for TCP transitory connections. Defaults to 30s if not set.
      # - log_config (object, optional):
      #    - filter: Specifies the desired filtering of logs on this NAT. Defaults to "ALL".
      # - subnetworks (list(objects), optional):
      #   - name (string, required): subnetwork name to NAT.
      #   - source_ip_ranges_to_nat (string, required): List of options for which source IPs in the subnetwork should have NAT enabled.
      #   - secondary_ip_range_names (string, optional): List of the secondary ranges of the subnetwork that are allowed to use NAT.
      nats = optional(map(object({
        region                             = string
        nat_ip_allocate_option             = optional(string, "AUTO_ONLY")
        source_subnetwork_ip_ranges_to_nat = optional(string, "ALL_SUBNETWORKS_ALL_IP_RANGES")
        nat_ips                            = optional(list(string), [])
        min_ports_per_vm                   = optional(number, 0)
        max_ports_per_vm                   = optional(number, 0)
        udp_idle_timeout_sec               = optional(number, 30)
        icmp_idle_timeout_sec              = optional(number, 30)
        tcp_established_idle_timeout_sec   = optional(number, 1200)
        tcp_transitory_idle_timeout_sec    = optional(number, 30)
        log_config = optional(object({
          enable = optional(bool, false)
          filter = optional(string, "ALL")
        }), {})
        subnetworks = optional(list(object({
          name                     = string
          source_ip_ranges_to_nat  = list(string)
          secondary_ip_range_names = optional(list(string), [])
        })), [])
      })), {})
    }))
  }))
}

variable "private_dns" {
  description = "Map of private DNS zones to create. Key is the name of the zone"
  type = map(object({
    domain  = string // Must end with a dot. e.g. dev.example.com.
    project = string // Project Name specified in var.projects
    vpc     = string // VPC Name specified in var.projects
    recordsets = optional(list(object({
      name    = string
      type    = string
      ttl     = number
      records = list(string)
    })), [])
  }))
}