module "admin_project" {
  source                      = "terraform-google-modules/project-factory/google"
  version                     = "~> 14.1"
  name                        = "cloud-administration"
  random_project_id           = true
  disable_services_on_destroy = false
  folder_id                   = google_folder.admin.id
  org_id                      = var.org_id
  billing_account             = var.billing_account_id
  create_project_sa           = false
  default_service_account     = "deprivilege"
  labels = {
    environment       = "cloud-administration"
    application_name  = "cloud-administration"
    billing_code      = "1234"
    primary_contact   = "example1"
    secondary_contact = "example2"
    business_code     = "abcd"
    env_code          = "b"
  }
  lien = true
  activate_apis = [
    "sts.googleapis.com",
    "iamcredentials.googleapis.com",
    "serviceusage.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "bigquery.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com",
    "appengine.googleapis.com",
    "storage-api.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "securitycenter.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "billingbudgets.googleapis.com",
    "essentialcontacts.googleapis.com"
  ]
}

module "org_audit_logs_project" {
  source                  = "terraform-google-modules/project-factory/google"
  version                 = "~> 14.1"
  random_project_id       = true
  default_service_account = "deprivilege"
  name                    = "central-audit-logging"
  org_id                  = var.org_id
  billing_account         = var.billing_account_id
  folder_id               = google_folder.admin.id
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
  folder_id               = google_folder.admin.id
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
