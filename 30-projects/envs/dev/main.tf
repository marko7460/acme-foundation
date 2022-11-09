variable "billing_account_id" {
  description = "The ID of the billing account to associate this project with. This is set in the workspaces"
}

variable "org_id" {
  description = "The ID of the organization to create the project in. This is set in the workspaces"
}

variable "tfc_organization" {
  description = "The TFC organization name"
}

variable "workload_identity_pool_provider_id" {
  description = "GCP workload identity pool provider ID. Set this value in your workspace after the initial deployement"
  type        = string
}

module "projects" {
  source                             = "../../modules/projects"
  billing_account_id                 = var.billing_account_id
  org_id                             = var.org_id
  tfc_organization                   = var.tfc_organization
  terraform_service_account          = "tf-project-creator-dev"
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  tfc_host_project_workspace         = "10-shared-vpc-projects-dev"
  tfc_host_networking_workspace      = "20-shared-vpc-networking-dev"
  folder                             = "dev"
  projects = {
    service-prj-dev = {
      svpc_host_project = "shared-vpc-dev"
      shared_vpc_subnets = [
        {
          network     = "base-shared-network"
          region      = "us-central1"
          subnet_name = "base-secondary"
        }
      ]
      labels = {
        environment       = "dev"
        application_name  = "login-management"
        billing_code      = "5348"
        primary_contact   = "admin"
        secondary_contact = "devops"
        business_code     = "34"
        vpc_type          = "base-shared"
      }
    }
    restricted-svc-prj-dev = {
      svpc_host_project = "restricted-shared-vpc-dev"
      shared_vpc_subnets = [
        {
          network     = "restricted-shared-network"
          region      = "us-central1"
          subnet_name = "restricted-secondary"
        }
      ]
      vpc_service_control_attach_enabled = true
      access_context_manager_policy_name = "acme-policy"
      vpc_service_control_name           = "restricted-shared-network"
      labels = {
        environment       = "dev"
        application_name  = "login-data-management"
        billing_code      = "5349"
        primary_contact   = "admin"
        secondary_contact = "devops"
        business_code     = "36"
        vpc_type          = "restricted-shared"
      }
      activate_apis = [
        "compute.googleapis.com",
        "accesscontextmanager.googleapis.com",
      ]
    }
    floating-prj-dev = {
      labels = {
        environment       = "dev"
        application_name  = "backed"
        billing_code      = "5350"
        primary_contact   = "admin"
        secondary_contact = "devops"
        business_code     = "38"
        vpc_type          = "restricted-shared"
      }
    }
  }
}

output "projects" {
  description = "Projects created"
  value       = module.projects.projects
}