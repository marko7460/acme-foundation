# service-projects
This is a root module that creates service projects per environment.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| billing\_account\_id | Billing Account ID | `any` | n/a | yes |
| folder | Environment folder | `any` | n/a | yes |
| org\_id | Organization ID | `any` | n/a | yes |
| projects | Map of projects to create. Key is the name of the project | <pre>map(object({<br>    svpc_host_project = optional(string, "")<br>    shared_vpc_subnets = optional(list(object({<br>      subnet_name = string<br>      region      = string<br>      network     = string<br>    })), [])<br>    vpc_service_control_attach_enabled = optional(bool, false)<br>    vpc_service_control_sleep_duration = optional(string, "60s")<br>    access_context_manager_policy_name = optional(string, null)<br>    vpc_service_control_name           = optional(string, "") //Name of the shared VPC that is part of the service control perimeter<br>    labels                             = optional(map(string), {})<br>    activate_apis = optional(list(string), [<br>      "compute.googleapis.com",<br>      "container.googleapis.com",<br>      "dataproc.googleapis.com",<br>      "dataflow.googleapis.com",<br>      "composer.googleapis.com",<br>      "vpcaccess.googleapis.com",<br>      "dns.googleapis.com",<br>      "servicenetworking.googleapis.com",<br>    ])<br>  }))<br></pre> | n/a | yes |
| terraform\_service\_account | The service account id used by Terraform Cloud to access GCP. This is set in 01-administration/terraform.tfvars | `any` | n/a | yes |
| tfc\_host\_networking\_workspace | TFC workspace holding host project networking outputs | `any` | n/a | yes |
| tfc\_host\_project\_workspace | TFC workspace holding host project outputs | `any` | n/a | yes |
| tfc\_organization | The TFC organization name | `any` | n/a | yes |
| workload\_identity\_pool\_provider\_id | GCP workload identity pool provider ID. Set this value in your workspace after the initial deployement | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| projects | projects |