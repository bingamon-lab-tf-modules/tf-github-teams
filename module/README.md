# tf-github-teams

## Table of Contents

- [tf-github-teams](#tf-github-teams)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Documentation](#documentation)

## Overview

This module configures teams for a GitHub Organization.

## Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 6.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_team.this](https://registry.terraform.io/providers/integrations/github/6.6.0/docs/resources/team) | resource |
| [github_team_membership.this](https://registry.terraform.io/providers/integrations/github/6.6.0/docs/resources/team_membership) | resource |
| [github_enterprise.this](https://registry.terraform.io/providers/integrations/github/6.6.0/docs/data-sources/enterprise) | data source |
| [github_organization.this](https://registry.terraform.io/providers/integrations/github/6.6.0/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_enterprise_slug"></a> [github\_enterprise\_slug](#input\_github\_enterprise\_slug) | The slug of the GitHub Enterprise where resources will be created.<br/><br/>  This is needed by the GitHub Enterprise Terraform provider.<br/><br/>  This can be set via either;<br/><br/>  - TF\_VAR\_github\_enterprise\_slug environment variable.<br/>  - github\_enterprise\_slug variable in the terraform.tfvars file. | `string` | n/a | yes |
| <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name) | Required. The name of the GitHub organization to create the team in. | `string` | n/a | yes |
| <a name="input_github_teams"></a> [github\_teams](#input\_github\_teams) | n/a | <pre>list(object({<br/>    # Team<br/>    name        = string<br/>    description = optional(string)<br/>    privacy     = optional(string)<br/>    ldap_dn     = optional(string)<br/><br/>    # Team Members<br/>    members = list(object({<br/>      username = string<br/>      role     = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_teams"></a> [teams](#output\_teams) | Map of team data to pass to other modules |
<!-- END_TF_DOCS -->
