output "workspaces" {
  description = "Map of the workspace names and IDs"
  value = {
    "01-cloud-administration-global"  = tfe_workspace.cloud-administration-global.id
    "02-global-iam"                   = tfe_workspace.global-iam.id
    "03-org-policies"                 = tfe_workspace.org-policies.id
    "04-shared-services"              = tfe_workspace.shared-services.id
    "05-hierarchical-firewall-policy" = tfe_workspace.hierarchical-firewall-policy.id
    "10-shared-vpc-projects-dev"      = tfe_workspace.shared-vpc-project-dev.id
    "10-shared-vpc-projects-stg"      = tfe_workspace.shared-vpc-project-stg.id
    "10-shared-vpc-projects-prd"      = tfe_workspace.shared-vpc-project-prd.id
    "20-shared-vpc-networking-dev"    = tfe_workspace.shared-vpc-networking-dev.id
    "20-shared-vpc-networking-stg"    = tfe_workspace.shared-vpc-networking-stg.id
    "20-shared-vpc-networking-prd"    = tfe_workspace.shared-vpc-networking-prd.id
    "30-projects-dev"                 = tfe_workspace.projects-dev.id
    "30-projects-stg"                 = tfe_workspace.projects-stg.id
    "30-projects-prd"                 = tfe_workspace.projects-prd.id
  }
}