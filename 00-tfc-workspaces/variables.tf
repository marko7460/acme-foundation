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