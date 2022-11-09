output "service_accounts" {
  description = "Terraform service accounts"
  value = {
    for service_account, conf in google_service_account.tf-sa :
    service_account => {
      email = conf.email
      id    = conf.id
    }
  }
}

output "folders" {
  description = "Map of created folders"
  value       = google_folder.folders
}

output "projects" {
  description = "List of created projects"
  value = {
    "${module.admin_project.project_name}"          = module.admin_project
    "${module.org_audit_logs_project.project_name}" = module.org_audit_logs_project
    "${module.billing_logs_project.project_name}"   = module.billing_logs_project
  }
}

output "workload_identity_audience" {
  description = "TFC Workload Identity Audience."
  value       = "//iam.googleapis.com/${google_iam_workload_identity_pool_provider.tfe-pool-provider.name}"
}

output "workload_identity_pool_provider_id" {
  description = "GCP workload identity pool provider ID."
  value       = google_iam_workload_identity_pool_provider.tfe-pool-provider.name
}

output "service_account_self" {
  description = "Service Account that is used to self manage this workspace"
  value       = google_service_account.tf-cloud-admin-self.email
}