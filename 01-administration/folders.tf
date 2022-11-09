resource "google_folder" "folders" {
  for_each     = var.folders
  display_name = each.value
  parent       = "organizations/${var.org_id}"
}

resource "google_folder" "admin" {
  display_name = var.administration_folder_name
  parent       = "organizations/${var.org_id}"
}