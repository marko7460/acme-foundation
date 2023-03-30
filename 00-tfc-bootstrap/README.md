# 00-tfc-bootstrap
This code is in charge of bootstrapping the TFC workspaces and GCP Workload Identity. The code will: 
1. Create TFC workspaces for the deployment.
2. TFC-Bootstrap folder in GCP
3. GCP Bootstrap project with the following resources:
   1. Terraform service accounts for all the workspaces in the TFC organization
   2. IAM roles for the terraform service accounts
   3. Workload Identity Federation between GCP and TFC
4. GCP Environment folders

The output of this module is used in the all other workspaces.

## Prerequisites
* [Terraform](https://www.terraform.io/downloads.html) installed
* [Terraform Cloud](https://app.terraform.io/signup/account) account
* GitHub account connected to the Terraform Cloud account

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| tfe | ~> 0.43.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| billing\_account\_id | GCP Billing Account ID | `string` | n/a | yes |
| bootstrap\_folder\_name | Name of the GCP Bootstrap folder | `string` | `"TFC-Bootstrap"` | no |
| folders | Map of folder ids to folder names | `map(string)` | n/a | yes |
| github\_oauth\_client | Github OAuth Client ID setup in Terraform Cloud | `string` | n/a | yes |
| github\_repo | Github repository | `string` | n/a | yes |
| issuer\_uri | Terraform Enterprise uri. Replace the uri if a self hosted instance is used. | `string` | `"https://app.terraform.io/"` | no |
| org\_id | GCP Organization ID | `string` | n/a | yes |
| terraform\_service\_accounts | List of automation service accounts with respective roles that will be used by different workspaces | <pre>map(object({<br>    description            = string<br>    workspaces             = list(string)<br>    iam_folder_roles       = optional(map(list(string)), {})<br>    iam_organization_roles = optional(list(string), [])<br>  }))<br></pre> | n/a | yes |
| tfc\_organization | Terraform cloud organization | `string` | n/a | yes |
| tfc\_project | TFC Project Name | `string` | `"Foundation"` | no |
| workload\_identity\_pool\_id | Workload identity pool id. | `string` | `"tfe-pool"` | no |

## Outputs

| Name | Description |
|------|-------------|
| folders | Map of created folders |
| service\_account\_self | Service Account that is used to self manage this workspace |
| workspaces | Map of the workspace names and IDs |