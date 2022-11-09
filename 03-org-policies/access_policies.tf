module "org_policy" {
  source      = "terraform-google-modules/vpc-service-controls/google"
  version     = "~> 4.0"
  parent_id   = var.org_id
  policy_name = var.policy_name
}