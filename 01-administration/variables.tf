variable "tfc_organization" {
  description = "Terraform cloud organization name"
  type        = string
}

variable "tfc_organization_id" {
  description = "Terraform cloud organization ID. This value usually starts with 'org-'"
  type        = string
}

variable "org_id" {
  description = "GCP Organization ID"
}

variable "billing_account_id" {
  description = "GCP Billing Account ID"
}

variable "folders" {
  type        = map(string)
  description = "Map of folder ids to folder names"
}

variable "administration_folder_name" {
  description = "Name of the administration folder"
  type        = string
  default     = "Cloud administration"
}

variable "terraform_service_accounts" {
  description = "List of service accounts to grant roles/owner to"
  type = map(object({
    description            = string
    workspaces             = list(string)
    iam_folder_roles       = optional(map(list(string)), {})
    iam_organization_roles = optional(list(string), [])
  }))
}

variable "audit_log_filter" {
  type        = string
  description = "Log filter for the sink"
  default     = <<EOF
    logName: /logs/cloudaudit.googleapis.com%2Factivity OR
    logName: /logs/cloudaudit.googleapis.com%2Fsystem_event OR
    logName: /logs/cloudaudit.googleapis.com%2Fdata_access OR
    logName: /logs/compute.googleapis.com%2Fvpc_flows OR
    logName: /logs/compute.googleapis.com%2Ffirewall OR
    logName: /logs/cloudaudit.googleapis.com%2Faccess_transparency
EOF
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

variable "use_google_oath_token" {
  description = "Use Google Oauth token for authentication."
  type        = bool
  default     = true
}

variable "workload_identity_pool_provider_id" {
  description = "GCP workload identity pool provider ID. Set this value in your workspace after the initial deployement"
  type        = string
  default     = ""
}