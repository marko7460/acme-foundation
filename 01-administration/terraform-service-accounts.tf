# Defining terraform service accounts to be used in workload identity federation
locals {
  sa_folder_iam_array = flatten([
    for sa, conf in var.terraform_service_accounts : [
      for folder, roles in conf.iam_folder_roles : [
        for role in roles : {
          id                 = "${sa}/${folder}/${role}"
          service_account_id = sa
          role               = role
          folder             = folder
  }]]])
  sa_folder_iam = { for sa in local.sa_folder_iam_array : sa.id => sa }

  sa_org_iam_array = flatten([for sa, conf in var.terraform_service_accounts : [for role in conf.iam_organization_roles : {
    id                 = "${sa}/${role}"
    service_account_id = sa
    role               = role
  }]])
  sa_org_iam = { for sa in local.sa_org_iam_array : sa.id => sa }
}

resource "google_service_account" "tf-sa" {
  for_each    = var.terraform_service_accounts
  account_id  = each.key
  project     = module.admin_project.project_id
  description = each.value.description
}

resource "google_service_account_iam_binding" "principles" {
  for_each           = var.terraform_service_accounts
  service_account_id = google_service_account.tf-sa[each.key].name
  role               = "roles/iam.workloadIdentityUser"
  members            = [for workspace in each.value.workspaces : "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.tfe-pool.name}/attribute.terraform_workspace_id/${data.tfe_outputs.workspaces.values.workspaces[workspace]}"]
}

resource "google_folder_iam_member" "folders" {
  for_each = local.sa_folder_iam
  folder   = google_folder.folders[each.value.folder].id
  role     = each.value.role
  member   = "serviceAccount:${google_service_account.tf-sa[each.value.service_account_id].email}"
}

resource "google_organization_iam_member" "org" {
  for_each = local.sa_org_iam
  org_id   = var.org_id
  role     = each.value.role
  member   = "serviceAccount:${google_service_account.tf-sa[each.value.service_account_id].email}"
}

resource "google_service_account_iam_binding" "self-manage" {
  service_account_id = google_service_account.tf-cloud-admin-self.name
  role               = "roles/iam.workloadIdentityUser"
  members            = ["principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.tfe-pool.name}/attribute.terraform_workspace_id/${nonsensitive(data.tfe_outputs.workspaces.values.workspaces["01-cloud-administration-global"])}"]
}

resource "google_service_account" "tf-cloud-admin-self" {
  account_id  = "tf-cloud-admin-self-service"
  project     = module.admin_project.project_id
  description = "Service account for self managing of this workspace"
}

resource "google_organization_iam_member" "self-managed-sa-org" {
  for_each = toset([
    "roles/billing.user",
    "roles/compute.xpnAdmin",
    "roles/iam.securityAdmin",
    "roles/logging.viewer",
    "roles/resourcemanager.organizationViewer",
    "roles/resourcemanager.folderIamAdmin",
    "roles/resourcemanager.folderEditor",
    "roles/accesscontextmanager.policyAdmin",
  ])
  org_id = var.org_id
  role   = each.key
  member = "serviceAccount:${google_service_account.tf-cloud-admin-self.email}"
}

resource "google_folder_iam_member" "self-managed-admin-folder" {
  for_each = toset([
    "roles/resourcemanager.projectCreator",
    "roles/compute.networkAdmin",
    "roles/browser",
    "roles/resourcemanager.projectIamAdmin",
    "roles/compute.securityAdmin",
    "roles/logging.admin",
    "roles/storage.admin",
    "roles/iam.workloadIdentityUser",
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.securityAdmin",
    "roles/iam.securityAdmin",
  ])
  folder = google_folder.admin.id
  role   = each.key
  member = "serviceAccount:${google_service_account.tf-cloud-admin-self.email}"
}
