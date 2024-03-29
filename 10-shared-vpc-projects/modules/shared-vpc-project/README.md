# shared-vpc-project
Root module that creates shared vpc projects in different environments.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| billing\_account\_id | Billing Account ID | `any` | n/a | yes |
| org\_id | Organization ID | `any` | n/a | yes |
| projects | Map of projects to create. Key is the name of the project | <pre>map(object({<br>    folder = string<br>    labels = optional(map(string), {})<br>    activate_apis = optional(list(string), [<br>      "compute.googleapis.com",<br>      "container.googleapis.com",<br>      "dataproc.googleapis.com",<br>      "dataflow.googleapis.com",<br>      "composer.googleapis.com",<br>      "vpcaccess.googleapis.com",<br>      "dns.googleapis.com",<br>      "servicenetworking.googleapis.com",<br>    ])<br>  }))<br></pre> | n/a | yes |
| tfc\_organization | The TFC organization name | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| projects | Shared VPC Project outputs |

