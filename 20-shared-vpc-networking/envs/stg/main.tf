variable "tfc_organization" {
  description = "The TFC organization name"
}

variable "workload_identity_pool_provider_id" {
  description = "GCP workload identity pool provider ID. Set this value in your workspace after the initial deployement"
  type        = string
}

data "tfe_outputs" "admin-global" {
  organization = var.tfc_organization
  workspace    = "01-cloud-administration-global"
}

locals {
  self_sa = data.tfe_outputs.admin-global.values.service_accounts["tf-project-creator-stg"].email
}

module "shared_vpcs" {
  source                             = "../../modules/networking"
  tfc_workspace_for_host_project     = "10-shared-vpc-projects-stg"
  terraform_service_account          = "tf-project-creator-stg"
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  tfc_organization                   = var.tfc_organization
  shared_vpcs = {
    base-shared-network = {
      host_project               = "shared-vpc-stg"
      private_service_cidr       = "10.16.128.0/21"
      private_service_connect_ip = "10.2.128.5"
      domain                     = "stg.acme.private."
      subnets = [
        {
          subnet_name           = "base-primary"
          subnet_ip             = "10.0.128.0/21"
          subnet_region         = "us-west1"
          subnet_private_access = "true"
          subnet_flow_logs      = "false"
          description           = "To be shared with service project"
        },
        {
          subnet_name           = "base-secondary"
          subnet_ip             = "10.1.128.0/21"
          subnet_region         = "us-central1"
          subnet_private_access = "true"
          subnet_flow_logs      = "false"
          description           = "To be shared with service project"
        },
      ]
      secondary_ranges = {
        "base-primary" = [
          {
            range_name    = "pods"
            ip_cidr_range = "100.64.128.0/21"
          },
          {
            range_name    = "services"
            ip_cidr_range = "100.64.136.0/21"
          }
        ],
      }
      nats = {
        nat1 = {
          region                             = "us-west1"
          source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
          subnetworks = [
            {
              name                    = "base-primary"
              source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
            }
          ]
        }
      }
    }
    restricted-shared-network = {
      host_project                       = "restricted-shared-vpc-stg"
      private_service_cidr               = "10.24.128.0/21"
      private_service_connect_ip         = "10.10.128.5"
      domain                             = "restricted-stg.acme.private."
      access_context_manager_policy_name = "acme-policy"
      vpc_access_members                 = ["serviceAccount:${local.self_sa}"]
      subnets = [
        {
          subnet_name           = "restricted-primary"
          subnet_ip             = "10.8.128.0/21"
          subnet_region         = "us-west1"
          subnet_private_access = "true"
          subnet_flow_logs      = "false"
          description           = "To be shared with service project"
        },
        {
          subnet_name           = "restricted-secondary"
          subnet_ip             = "10.9.128.0/21"
          subnet_region         = "us-central1"
          subnet_private_access = "true"
          subnet_flow_logs      = "false"
          description           = "To be shared with service project"
        },
      ]
      secondary_ranges = {
        "restricted-primary" = [
          {
            range_name    = "pods"
            ip_cidr_range = "100.72.128.0/21"
          },
          {
            range_name    = "services"
            ip_cidr_range = "100.72.136.0/21"
          }
        ],
      }
      nats = {
        nat1 = {
          region                             = "us-west1"
          source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
          subnetworks = [
            {
              name                    = "restricted-primary"
              source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
            }
          ]
        }
      }
    }
  }
}

output "shared_vpc_networks" {
  value     = module.shared_vpcs.vpc
  sensitive = true
}

output "vpc_service_perimeter" {
  description = "VPC Service Permiter"
  value       = module.shared_vpcs.vpc_service_perimeter
}