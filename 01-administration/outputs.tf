output "projects" {
  description = "List of created projects"
  value = {
    "${module.org_audit_logs_project.project_name}" = module.org_audit_logs_project
    "${module.billing_logs_project.project_name}"   = module.billing_logs_project
  }
}