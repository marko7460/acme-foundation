variable "tfc_organization" {
  description = "Terraform cloud organization"
  type        = string
}

variable "org_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "workload_identity_pool_provider_id" {
  description = "GCP workload identity pool provider ID. Set this value in your workspace after the initial deployement"
  type        = string
}

variable "essential_contacts_domains_to_allow" {
  description = "The list of domains that email addresses added to Essential Contacts can have."
  type        = list(string)
}

variable "domains_to_allow" {
  description = "The list of domains to allow users from in IAM. Used by Domain Restricted Sharing Organization Policy. Must include the domain of the organization you are deploying the foundation. To add other domains you must also grant access to these domains to the Terraform Service Account used in the deploy."
  type        = list(string)
}

variable "policy_name" {
  description = "The Access Context policy's name."
  type        = string
}