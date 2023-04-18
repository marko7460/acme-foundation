# 01-administration
This root module creates administrative projects for audit logging and billing. The projects are located in the admin
folder. The module will create:
1. Central audit logging project that collects logs from all the projects in the organization
2. Billing project that collects logs from the billing account

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| audit\_log\_filter | Log filter for the sink | `string` | `"    logName: /logs/cloudaudit.googleapis.com%2Factivity OR\n    logName: /logs/cloudaudit.googleapis.com%2Fsystem_event OR\n    logName: /logs/cloudaudit.googleapis.com%2Fdata_access OR\n    logName: /logs/compute.googleapis.com%2Fvpc_flows OR\n    logName: /logs/compute.googleapis.com%2Ffirewall OR\n    logName: /logs/cloudaudit.googleapis.com%2Faccess_transparency\n"` | no |
| billing\_account\_id | GCP Billing Account ID | `any` | n/a | yes |
| org\_id | GCP Organization ID | `any` | n/a | yes |
| tfc\_organization | Terraform cloud organization name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| projects | List of created projects |