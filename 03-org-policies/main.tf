data "tfe_outputs" "admin-global" {
  organization = var.tfc_organization
  workspace    = "01-cloud-administration-global"
}

locals {
  essential_contacts_domains_to_allow = concat(
    [for domain in var.essential_contacts_domains_to_allow : "${domain}" if can(regex("^@.*$", domain)) == true],
    [for domain in var.essential_contacts_domains_to_allow : "@${domain}" if can(regex("^@.*$", domain)) == false]
  )
  boolean_type_organization_policies = toset([
    "compute.disableNestedVirtualization",
    "compute.disableSerialPortAccess",
    "compute.disableGuestAttributesAccess",
    "compute.skipDefaultNetworkCreation",
    "compute.restrictXpnProjectLienRemoval",
    "compute.disableVpcExternalIpv6",
    "compute.setNewProjectDefaultToZonalDNSOnly",
    "compute.requireOsLogin",
    "sql.restrictPublicIp",
    "sql.restrictAuthorizedNetworks",
    "iam.disableServiceAccountKeyCreation",
    "iam.automaticIamGrantsForDefaultServiceAccounts",
    "iam.disableServiceAccountKeyUpload",
    "storage.uniformBucketLevelAccess",
    "storage.publicAccessPrevention"
  ])
}

module "organization_policies_type_boolean" {
  for_each        = local.boolean_type_organization_policies
  source          = "terraform-google-modules/org-policy/google"
  version         = "~> 5.2"
  organization_id = var.org_id
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = "true"
  constraint      = "constraints/${each.value}"
}

/******************************************
  Compute org policies
*******************************************/

module "org_vm_external_ip_access" {
  source          = "terraform-google-modules/org-policy/google"
  version         = "~> 5.2"
  organization_id = var.org_id
  policy_for      = "organization"
  policy_type     = "list"
  enforce         = "true"
  constraint      = "constraints/compute.vmExternalIpAccess"
}

module "restrict_protocol_fowarding" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.2"
  organization_id   = var.org_id
  policy_for        = "organization"
  policy_type       = "list"
  allow             = ["INTERNAL"]
  allow_list_length = 1
  constraint        = "constraints/compute.restrictProtocolForwardingCreationForTypes"
}

/******************************************
  IAM
*******************************************/

module "org_domain_restricted_sharing" {
  source           = "terraform-google-modules/org-policy/google//modules/domain_restricted_sharing"
  version          = "~> 5.2"
  organization_id  = var.org_id
  policy_for       = "organization"
  domains_to_allow = var.domains_to_allow
}

/******************************************
  Essential Contacts
*******************************************/

module "domain_restricted_contacts" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.2"
  organization_id   = var.org_id
  policy_for        = "organization"
  policy_type       = "list"
  allow_list_length = length(local.essential_contacts_domains_to_allow)
  allow             = local.essential_contacts_domains_to_allow
  constraint        = "constraints/essentialcontacts.allowedContactDomains"
}