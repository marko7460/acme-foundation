variable "tfc_organization" {
  description = "The TFC organization name"
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