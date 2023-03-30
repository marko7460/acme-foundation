variable "tfc_organization" {
  description = "Terraform cloud organization name"
  type        = string
}

variable "org_id" {
  description = "GCP Organization ID"
}

variable "billing_account_id" {
  description = "GCP Billing Account ID"
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