# 01-administration
This root module is in charge of bootstraping the GCP organization. It will create the following resources:
1. Cloud Administration folder
2. Cloud Administration project with the following resources:
   1. Terraform service accounts for all the workspaces in the TFC organization created in [00-tfc-workspaces](../00-tfc-workspaces)
   2. IAM roles for the terraform service accounts
   3. Workload Identity Federation between GCP and TFC
3. Central audit logging project that collects logs from all the projects in the organization
4. Billing project that collects logs from the billing account
5. Environment folders

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| administration\_folder\_name | Name of the administration folder | `string` | `"Cloud administration"` | no |
| audit\_log\_filter | Log filter for the sink | `string` | `"    logName: /logs/cloudaudit.googleapis.com%2Factivity OR\n    logName: /logs/cloudaudit.googleapis.com%2Fsystem_event OR\n    logName: /logs/cloudaudit.googleapis.com%2Fdata_access OR\n    logName: /logs/compute.googleapis.com%2Fvpc_flows OR\n    logName: /logs/compute.googleapis.com%2Ffirewall OR\n    logName: /logs/cloudaudit.googleapis.com%2Faccess_transparency\n"` | no |
| billing\_account\_id | GCP Billing Account ID | `any` | n/a | yes |
| folders | Map of folder ids to folder names | `map(string)` | n/a | yes |
| issuer\_uri | Terraform Enterprise uri. Replace the uri if a self hosted instance is used. | `string` | `"https://app.terraform.io/"` | no |
| org\_id | GCP Organization ID | `any` | n/a | yes |
| terraform\_service\_accounts | List of service accounts to grant roles/owner to | <pre>map(object({<br>    description            = string<br>    workspaces             = list(string)<br>    iam_folder_roles       = optional(map(list(string)), {})<br>    iam_organization_roles = optional(list(string), [])<br>  }))<br></pre> | n/a | yes |
| tfc\_organization | Terraform cloud organization name | `string` | n/a | yes |
| tfc\_organization\_id | Terraform cloud organization ID. This value usually starts with 'org-' | `string` | n/a | yes |
| use\_google\_oath\_token | Use Google Oauth token for authentication. | `bool` | `true` | no |
| workload\_identity\_pool\_id | Workload identity pool id. | `string` | `"tfe-pool"` | no |
| workload\_identity\_pool\_provider\_id | GCP workload identity pool provider ID. Set this value in your workspace after the initial deployement | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| folders | Map of created folders |
| projects | List of created projects |
| service\_account\_self | Service Account that is used to self manage this workspace |
| service\_accounts | Terraform service accounts |
| workload\_identity\_audience | TFC Workload Identity Audience. |
| workload\_identity\_pool\_provider\_id | GCP workload identity pool provider ID. |