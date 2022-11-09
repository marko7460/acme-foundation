module "log_export_org" {
  source                 = "terraform-google-modules/log-export/google"
  version                = "~> 7.4.2"
  destination_uri        = module.destination_logbucket_org.destination_uri
  filter                 = var.audit_log_filter
  log_sink_name          = "logbucket_org_${random_string.suffix.result}"
  parent_resource_id     = var.org_id
  parent_resource_type   = "organization"
  unique_writer_identity = true
  include_children       = true
}

module "destination_logbucket_org" {
  source                   = "terraform-google-modules/log-export/google//modules/logbucket"
  version                  = "~> 7.4.2"
  project_id               = module.org_audit_logs_project.project_id
  name                     = "${module.org_audit_logs_project.project_id}-logbucket-org"
  location                 = "global"
  log_sink_writer_identity = module.log_export_org.writer_identity
}

module "destination_bucket_org" {
  source                   = "terraform-google-modules/log-export/google//modules/storage"
  project_id               = module.org_audit_logs_project.project_id
  storage_bucket_name      = "${module.org_audit_logs_project.project_id}-logbucket-org"
  log_sink_writer_identity = module.log_export_org.writer_identity
  versioning               = true
  location                 = "US"
  lifecycle_rules = [
    {
      action = {
        type          = "SetStorageClass"
        storage_class = "COLDLINE"
      }
      condition = {
        age        = 365
        with_state = "ANY"
      }
    }
  ]
}

module "log_export_billing" {
  source                 = "terraform-google-modules/log-export/google"
  destination_uri        = module.destination_bucket_billing.destination_uri
  log_sink_name          = "billing_logsink"
  parent_resource_id     = var.billing_account_id
  parent_resource_type   = "billing_account"
  unique_writer_identity = true
}

module "destination_bucket_billing" {
  source                   = "terraform-google-modules/log-export/google//modules/storage"
  project_id               = module.billing_logs_project.project_id
  storage_bucket_name      = "${module.billing_logs_project.project_id}-logbucket-billing"
  log_sink_writer_identity = module.log_export_billing.writer_identity
  versioning               = true
  location                 = "US"
  lifecycle_rules = [
    {
      action = {
        type          = "SetStorageClass"
        storage_class = "COLDLINE"
      }
      condition = {
        age        = 365
        with_state = "ANY"
      }
    }
  ]
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}