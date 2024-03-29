# 05-hierarchical-firewall-policy
This root module allows central management of firewall rules for a GCP organization. It is based on the
[hierarchical firewall policy](https://cloud.google.com/vpc/docs/firewalls#hierarchical_firewall_policy) feature of GCP.
This feature allows to create firewall rules at the organization level, which will be applied to all projects in the 
organization.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| associations | Resources to associate the policy to | `list(string)` | n/a | yes |
| org\_id | Organization ID | `any` | n/a | yes |
| rules | Firewall rules to add to the policy | <pre>map(object({<br>    description             = string<br>    direction               = string<br>    action                  = string<br>    priority                = number<br>    ranges                  = list(string)<br>    ports                   = map(list(string))<br>    target_service_accounts = list(string)<br>    target_resources        = list(string)<br>    logging                 = bool<br>  }))<br></pre> | `{}` | no |
| tfc\_organization | The TFC organization name | `any` | n/a | yes |

## Outputs

No output.
