variable "tfc_organization" {
  description = "The TFC organization name"
}

variable "billing_account_id" {
  description = "Billing Account ID"
}

variable "org_id" {
  description = "Organization ID"
}

variable "projects" {
  description = "Map of projects to create. Key is the name of the project"
  type = map(object({
    folder = string
    labels = optional(map(string), {})
    activate_apis = optional(list(string), [
      "compute.googleapis.com",
      "container.googleapis.com",
      "dataproc.googleapis.com",
      "dataflow.googleapis.com",
      "composer.googleapis.com",
      "vpcaccess.googleapis.com",
      "dns.googleapis.com",
      "servicenetworking.googleapis.com",
    ])
  }))
}