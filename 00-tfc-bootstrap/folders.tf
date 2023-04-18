resource "google_folder" "folders" {
  for_each     = var.folders
  display_name = each.value
  parent       = "organizations/${var.org_id}"
}

resource "google_folder" "bootstrap" {
  display_name = var.bootstrap_folder_name
  parent       = "organizations/${var.org_id}"
}