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
    "shared-vpc-stg" = {
      folder = "stg"
      labels = {
        environment       = "stg"
        application_name  = "base-shared-vpc-host"
        billing_code      = "9101"
        primary_contact   = "example1"
        secondary_contact = "example2"
        business_code     = "share"
        env_code          = "44"
      }
    }
    "restricted-shared-vpc-stg" = {
      folder = "stg"
      labels = {
        environment       = "stg"
        application_name  = "restricted-shared-vpc-host"
        billing_code      = "2001"
        primary_contact   = "example1"
        secondary_contact = "example2"
        business_code     = "abcd"
        env_code          = "21"
      }
    }
  }
}

output "projects" {
  value = module.projects.projects
}