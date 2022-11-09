# 00-tfc-workspaces
Workspaces for acme-foundations repo. This code will create necessary workspaces for the
[acme-foundations](https://github.com/marko7460/acme-foundations) repo.
The output of this module is used in the [01-administration](../01-administration) module.

## Prerequisites
* [Terraform](https://www.terraform.io/downloads.html) installed
* [Terraform Cloud](https://app.terraform.io/signup/account) account
* GitHub account connected to the Terraform Cloud account

## Providers

| Name | Version |
|------|---------|
| tfe | ~> 0.38.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| billing\_account\_id | GCP Billing Account ID | `string` | n/a | yes |
| github\_oauth\_client | Github OAuth Client ID setup in Terraform Cloud | `string` | n/a | yes |
| github\_repo | Github repository | `string` | n/a | yes |
| org\_id | GCP Organization ID | `string` | n/a | yes |
| tfc\_organization | Terraform cloud organization | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| workspaces | Map of the workspace names and IDs |
