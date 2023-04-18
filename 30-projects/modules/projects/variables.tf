variable "tfc_organization" {
  description = "The TFC organization name"
}

variable "tfc_host_project_workspace" {
  description = "TFC workspace holding host project outputs"
}

variable "tfc_host_networking_workspace" {
  description = "TFC workspace holding host project networking outputs"
}

variable "billing_account_id" {
  description = "Billing Account ID"
}

variable "org_id" {
  description = "Organization ID"
}

variable "folder" {
  description = "Environment folder"
}

variable "projects" {
  description = "Map of projects to create. Key is the name of the project"
  type = map(object({
    svpc_host_project = optional(string, "")
    shared_vpc_subnets = optional(list(object({
      subnet_name = string
      region      = string
      network     = string
    })), [])
    vpc_service_control_attach_enabled = optional(bool, false)
    vpc_service_control_sleep_duration = optional(string, "60s")
    access_context_manager_policy_name = optional(string, null)
    vpc_service_control_name           = optional(string, "") //Name of the shared VPC that is part of the service control perimeter
    labels                             = optional(map(string), {})
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