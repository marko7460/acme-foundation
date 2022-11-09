administration_folder_name = "Cloud-Administration"
folders = {
  dev    = "acme-dev",
  stg    = "acme-stg",
  prd    = "acme-prd",
  shared = "acme-shared-services"
}
terraform_service_accounts = {
  "tf-project-creator-dev" = {
    description = "Service account that creates projects in the dev environments. Attach to appropriate dev folders."
    workspaces  = ["10-shared-vpc-projects-dev", "20-shared-vpc-networking-dev", "30-projects-dev"]
    iam_folder_roles = {
      dev = [
        "roles/resourcemanager.projectCreator",
        "roles/compute.networkAdmin",
        "roles/browser",
        "roles/resourcemanager.projectIamAdmin",
      ]
      shared = [
        "roles/dns.peer",
      ]
    }
    iam_organization_roles = [
      "roles/billing.user",
      "roles/resourcemanager.organizationViewer",
      "roles/compute.xpnAdmin",
      "roles/resourcemanager.folderViewer",
      "roles/accesscontextmanager.policyEditor",
    ]
  }
  "tf-project-creator-stg" = {
    description = "Service account that creates projects in the stg environments. Attach to appropriate folders."
    workspaces  = ["10-shared-vpc-projects-stg", "20-shared-vpc-networking-stg", "30-projects-stg"]
    iam_folder_roles = {
      stg = [
        "roles/resourcemanager.projectCreator",
        "roles/compute.networkAdmin",
        "roles/browser",
        "roles/resourcemanager.projectIamAdmin",
      ]
      shared = [
        "roles/dns.peer",
      ]
    }
    iam_organization_roles = [
      "roles/billing.user",
      "roles/resourcemanager.organizationViewer",
      "roles/compute.xpnAdmin",
      "roles/resourcemanager.folderViewer",
      "roles/accesscontextmanager.policyEditor",
    ]
  }
  "tf-project-creator-prd" = {
    description = "Service account that creates projects in the prd environments. Attach to appropriate folders."
    workspaces  = ["10-shared-vpc-projects-prd", "20-shared-vpc-networking-prd", "30-projects-prd"]
    iam_folder_roles = {
      prd = [
        "roles/resourcemanager.projectCreator",
        "roles/compute.networkAdmin",
        "roles/browser",
        "roles/resourcemanager.projectIamAdmin",
      ]
      shared = [
        "roles/dns.peer",
      ]
    }
    iam_organization_roles = [
      "roles/billing.user",
      "roles/resourcemanager.organizationViewer",
      "roles/compute.xpnAdmin",
      "roles/resourcemanager.folderViewer",
      "roles/accesscontextmanager.policyEditor"
    ]
  }
  "tf-project-creator-shared" = {
    description = "Service account that creates projects in the shared environments.Attach to appropriate folders."
    workspaces  = ["04-shared-services"]
    iam_folder_roles = {
      shared = [
        "roles/resourcemanager.projectCreator",
        "roles/compute.networkAdmin",
        "roles/browser",
        "roles/resourcemanager.projectIamAdmin",
      ]
    }
    iam_organization_roles = [
      "roles/billing.user",
      "roles/resourcemanager.organizationViewer",
      "roles/compute.xpnAdmin",
      "roles/resourcemanager.folderViewer"
    ]
  }
  "tf-org-policy-sa" = {
    description = "Service account used to modify the organization. Attach to the organization level."
    workspaces  = ["03-org-policies"]
    iam_organization_roles = [
      "roles/resourcemanager.organizationViewer",
      "roles/orgpolicy.policyAdmin",
      "roles/accesscontextmanager.policyAdmin",
    ]
  }
  "tf-global-iam-sa" = {
    description = "Service account used to IAM permission on folders and admin projects."
    workspaces  = ["02-global-iam"]
    iam_folder_roles = {
      dev = [
        "roles/resourcemanager.folderIamAdmin",
        "roles/resourcemanager.projectIamAdmin"
      ]
      stg = [
        "roles/resourcemanager.folderIamAdmin",
        "roles/resourcemanager.projectIamAdmin"
      ]
      prd = [
        "roles/resourcemanager.folderIamAdmin",
        "roles/resourcemanager.projectIamAdmin"
      ]
      shared = [
        "roles/resourcemanager.folderIamAdmin",
        "roles/resourcemanager.projectIamAdmin"
      ]
    }
    iam_organization_roles = [
      "roles/resourcemanager.organizationViewer",
      "roles/iam.securityAdmin",
    ]
  }
  "tf-firewall-policy" = {
    description = "Service account used to set firewall policies."
    workspaces  = ["05-hierarchical-firewall-policy"]
    iam_folder_roles = {
      dev = [
        "roles/compute.orgSecurityResourceAdmin",
      ]
      stg = [
        "roles/compute.orgSecurityResourceAdmin",
      ]
      prd = [
        "roles/compute.orgSecurityResourceAdmin",
      ]
      shared = [
        "roles/compute.orgSecurityResourceAdmin",
      ]
    }
    iam_organization_roles = [
      "roles/resourcemanager.organizationViewer",
      "roles/compute.orgFirewallPolicyAdmin",
      "roles/compute.orgSecurityPolicyAdmin",
    ]
  }
}