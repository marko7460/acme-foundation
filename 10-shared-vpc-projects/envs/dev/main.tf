variable "billing_account_id" {
  description = "The ID of the billing account to associate this project with. This is set in the workspaces"
}

variable "org_id" {
  description = "The ID of the organization to create the project in. This is set in the workspaces"
}

variable "tfc_organization" {
  description = "The TFC organization name"
}

module "projects" {
  source             = "../../modules/shared-vpc-project"
  billing_account_id = var.billing_account_id
  org_id             = var.org_id
  tfc_organization   = var.tfc_organization
  projects = {
    "shared-vpc-dev" = {
      folder = "dev"
      labels = {
        environment       = "dev"
        application_name  = "shared-vpc-host"
        billing_code      = "1234"
        primary_contact   = "example1"
        secondary_contact = "example2"
        business_code     = "abcd"
        env_code          = "11"
      }
    },
    "restricted-shared-vpc-dev" = {
      folder = "dev"
      labels = {
        environment       = "dev"
        application_name  = "restricted-shared-vpc-host"
        billing_code      = "7853"
        primary_contact   = "example1"
        secondary_contact = "example2"
        business_code     = "abcd"
        env_code          = "69"
      }
    }
  }
}

output "projects" {
  value = module.projects.projects
}