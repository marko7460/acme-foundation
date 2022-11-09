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

variable "org_bindings" {
  description = "Map of role (key) and list of members (value) to add the IAM policies/bindings"
  type        = map(list(string))
  default     = {}
}

variable "org_conditional_bindings" {
  description = "List of maps of role and respective conditions, and the members to add the IAM policies/bindings"
  type = list(object({
    role        = string
    title       = string
    description = string
    expression  = string
    members     = list(string)
  }))
  default = []
}

variable "folders_iam" {
  description = "Map of folder names (key) and list of members (value) to add the IAM policies/bindings"
  type = map(object({
    bindings = map(list(string))
    conditional_bindings = optional(list(object({
      role        = string
      title       = string
      description = string
      expression  = string
      members     = list(string)
    })), [])
  }))
  default = {}
}

variable "audit_bindings" {
  description = "Map of role (key) and list of members (value) to add the IAM policies/bindings"
  type        = map(list(string))
  default     = {}
}

variable "audit_conditional_bindings" {
  description = "List of maps of role and respective conditions, and the members to add the IAM policies/bindings"
  type = list(object({
    role        = string
    title       = string
    description = string
    expression  = string
    members     = list(string)
  }))
  default = []
}


variable "admin_bindings" {
  description = "Map of role (key) and list of members (value) to add the IAM policies/bindings"
  type        = map(list(string))
  default     = {}
}

variable "admin_conditional_bindings" {
  description = "List of maps of role and respective conditions, and the members to add the IAM policies/bindings"
  type = list(object({
    role        = string
    title       = string
    description = string
    expression  = string
    members     = list(string)
  }))
  default = []
}

variable "billing_project_bindings" {
  description = "Map of role (key) and list of members (value) to add the IAM policies/bindings"
  type        = map(list(string))
  default     = {}
}

variable "billing_project_conditional_bindings" {
  description = "List of maps of role and respective conditions, and the members to add the IAM policies/bindings"
  type = list(object({
    role        = string
    title       = string
    description = string
    expression  = string
    members     = list(string)
  }))
  default = []
}