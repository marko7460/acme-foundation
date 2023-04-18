variable "tfc_organization" {
  description = "Terraform cloud organization"
  type        = string
}

variable "org_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "billing_account_id" {
  description = "GCP Billing Account ID"
  type        = string
}

variable "github_repo" {
  description = "Github repository"
  type        = string
}

variable "github_oauth_client" {
  description = "Github OAuth Client ID setup in Terraform Cloud"
  type        = string
}

variable "tfc_project" {
  description = "TFC Project Name"
  type        = string
  default     = "Foundation"
}

variable "bootstrap_folder_name" {
  description = "Name of the GCP Bootstrap folder"
  type        = string
  default     = "TFC-Bootstrap"
}

variable "terraform_service_accounts" {
  description = "List of automation service accounts with respective roles that will be used by different workspaces"
  type = map(object({
    description            = string
    workspaces             = list(string)
    iam_folder_roles       = optional(map(list(string)), {})
    iam_organization_roles = optional(list(string), [])
  }))
}

variable "issuer_uri" {
  description = "Terraform Enterprise uri. Replace the uri if a self hosted instance is used."
  type        = string
  default     = "https://app.terraform.io/"
}

variable "workload_identity_pool_id" {
  description = "Workload identity pool id."
  type        = string
  default     = "tfe-pool"
}

variable "folders" {
  type        = map(string)
  description = "Map of folder ids to folder names"
}