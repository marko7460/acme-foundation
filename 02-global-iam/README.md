# 02-global-iam
This root module sets up the global IAM policies for the organization. Use this module to give users and groups access
to various environments in the organization

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| admin\_bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | `{}` | no |
| admin\_conditional\_bindings | List of maps of role and respective conditions, and the members to add the IAM policies/bindings | <pre>list(object({<br>    role        = string<br>    title       = string<br>    description = string<br>    expression  = string<br>    members     = list(string)<br>  }))<br></pre> | `[]` | no |
| audit\_bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | `{}` | no |
| audit\_conditional\_bindings | List of maps of role and respective conditions, and the members to add the IAM policies/bindings | <pre>list(object({<br>    role        = string<br>    title       = string<br>    description = string<br>    expression  = string<br>    members     = list(string)<br>  }))<br></pre> | `[]` | no |
| billing\_project\_bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | `{}` | no |
| billing\_project\_conditional\_bindings | List of maps of role and respective conditions, and the members to add the IAM policies/bindings | <pre>list(object({<br>    role        = string<br>    title       = string<br>    description = string<br>    expression  = string<br>    members     = list(string)<br>  }))<br></pre> | `[]` | no |
| folders\_iam | Map of folder names (key) and list of members (value) to add the IAM policies/bindings | <pre>map(object({<br>    bindings = map(list(string))<br>    conditional_bindings = optional(list(object({<br>      role        = string<br>      title       = string<br>      description = string<br>      expression  = string<br>      members     = list(string)<br>    })), [])<br>  }))<br></pre> | `{}` | no |
| org\_bindings | Map of role (key) and list of members (value) to add the IAM policies/bindings | `map(list(string))` | `{}` | no |
| org\_conditional\_bindings | List of maps of role and respective conditions, and the members to add the IAM policies/bindings | <pre>list(object({<br>    role        = string<br>    title       = string<br>    description = string<br>    expression  = string<br>    members     = list(string)<br>  }))<br></pre> | `[]` | no |
| org\_id | GCP Organization ID | `string` | n/a | yes |
| tfc\_organization | Terraform cloud organization | `string` | n/a | yes |
| workload\_identity\_pool\_provider\_id | GCP workload identity pool provider ID. Set this value in your workspace after the initial deployement | `string` | n/a | yes |

## Outputs

No output.