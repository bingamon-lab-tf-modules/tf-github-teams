# tf-github-teams

## Table of Contents

- [tf-github-teams](#tf-github-teams)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Documentation](#documentation)

## Overview

This module configures teams for a GitHub Organization.

It also grants the organization `security_manager` role to one of those teams when
`github_security_manager_team_slug` is set, using `github_organization_role_team`. This supersedes
the deprecated `github_organization_security_manager` resource, and with it the `tf-github-secmgr`
module.

## Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_organization_role_team.security_manager](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_role_team) | resource |
| [github_team.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team_membership.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) | resource |
| [github_enterprise.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/enterprise) | data source |
| [github_organization.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization) | data source |
| [github_organization_roles.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_enterprise_slug"></a> [github\_enterprise\_slug](#input\_github\_enterprise\_slug) | The slug of the GitHub Enterprise where resources will be created.<br/><br/>  This is needed by the GitHub Enterprise Terraform provider.<br/><br/>  This can be set via either;<br/><br/>  - TF\_VAR\_github\_enterprise\_slug environment variable.<br/>  - github\_enterprise\_slug variable in the terraform.tfvars file. | `string` | n/a | yes |
| <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name) | Required. The name of the GitHub organization to create the team in. | `string` | n/a | yes |
| <a name="input_github_security_manager_team_slug"></a> [github\_security\_manager\_team\_slug](#input\_github\_security\_manager\_team\_slug) | Slug of the team to grant the organization security\_manager role. Null disables the grant. | `string` | `null` | no |
| <a name="input_github_teams"></a> [github\_teams](#input\_github\_teams) | n/a | <pre>list(object({<br/>    # Team<br/>    name                 = string<br/>    description          = optional(string)<br/>    privacy              = optional(string)<br/>    ldap_dn              = optional(string)<br/>    notification_setting = optional(string, "notifications_enabled")<br/><br/>    # Team Members<br/>    members = list(object({<br/>      username = string<br/>      role     = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_manager"></a> [security\_manager](#output\_security\_manager) | Details of the organization security\_manager role grant, or null when not configured |
| <a name="output_teams"></a> [teams](#output\_teams) | Map of team data to pass to other modules |
<!-- END_TF_DOCS -->
