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

variable "org_id" {
  description = "Organization ID"
}

variable "rules" {
  description = "Firewall rules to add to the policy"
  type = map(object({
    description             = string
    direction               = string
    action                  = string
    priority                = number
    ranges                  = list(string)
    ports                   = map(list(string))
    target_service_accounts = list(string)
    target_resources        = list(string)
    logging                 = bool
  }))
  default = {}
}

variable "associations" {
  description = "Resources to associate the policy to"
  type        = list(string)
}