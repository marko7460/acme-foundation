# 03-org-policies
This root module manages GCP organization policies and creates the access context policy for the organization. The access
context policy is used to define access levels and access policies for the organization.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| domains\_to\_allow | The list of domains to allow users from in IAM. Used by Domain Restricted Sharing Organization Policy. Must include the domain of the organization you are deploying the foundation. To add other domains you must also grant access to these domains to the Terraform Service Account used in the deploy. | `list(string)` | n/a | yes |
| essential\_contacts\_domains\_to\_allow | The list of domains that email addresses added to Essential Contacts can have. | `list(string)` | n/a | yes |
| org\_id | GCP Organization ID | `string` | n/a | yes |
| policy\_name | The Access Context policy's name. | `string` | n/a | yes |
| tfc\_organization | Terraform cloud organization | `string` | n/a | yes |
| workload\_identity\_pool\_provider\_id | GCP workload identity pool provider ID. Set this value in your workspace after the initial deployement | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| access\_context\_manager\_policy\_ids | Resource names of the AccessPolicies that were created. This is a map of policy\_name => policy\_id |

