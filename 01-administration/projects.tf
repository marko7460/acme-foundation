module "org_audit_logs_project" {
  source                  = "terraform-google-modules/project-factory/google"
  version                 = "~> 14.1"
  random_project_id       = true
  default_service_account = "deprivilege"
  name                    = "central-audit-logging"
  org_id                  = var.org_id
  billing_account         = var.billing_account_id
  folder_id               = data.tfe_outputs.bootstrap.values.folders["admin"].folder_id
  activate_apis           = ["logging.googleapis.com", "bigquery.googleapis.com", "billingbudgets.googleapis.com"]

  labels = {
    environment       = "production"
    application_name  = "org-logging"
    billing_code      = "1234"
    primary_contact   = "example1"
    secondary_contact = "example2"
    business_code     = "abcd"
    env_code          = "p"
  }
}

module "billing_logs_project" {
  source                  = "terraform-google-modules/project-factory/google"
  version                 = "~> 14.1"
  random_project_id       = true
  default_service_account = "deprivilege"
  name                    = "billing-logs"
  org_id                  = var.org_id
  billing_account         = var.billing_account_id
  folder_id               = data.tfe_outputs.bootstrap.values.folders["admin"].folder_id
  activate_apis           = ["logging.googleapis.com", "bigquery.googleapis.com", "billingbudgets.googleapis.com"]

  labels = {
    environment       = "production"
    application_name  = "org-billing-logs"
    billing_code      = "1234"
    primary_contact   = "example1"
    secondary_contact = "example2"
    business_code     = "abcd"
    env_code          = "p"
  }
}
