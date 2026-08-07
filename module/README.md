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
| [github_organization_role_team.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_role_team) | resource |
| [github_team.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team_membership.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) | resource |
| [github_organization.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization) | data source |
| [github_organization_roles.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name) | Required. The name of the GitHub organization to create the team in. | `string` | n/a | yes |
| <a name="input_github_security_manager_team_slug"></a> [github\_security\_manager\_team\_slug](#input\_github\_security\_manager\_team\_slug) | Slug of the team to grant the organization security\_manager role. Null disables the grant. | `string` | `null` | no |
| <a name="input_github_teams"></a> [github\_teams](#input\_github\_teams) | n/a | <pre>list(object({<br/>    # Team<br/>    name                 = string<br/>    description          = optional(string)<br/>    privacy              = optional(string)<br/>    ldap_dn              = optional(string)<br/>    notification_setting = optional(string, "notifications_enabled")<br/><br/>    # Organization-wide baseline access.<br/>    #<br/>    # The name of a GitHub organization role granted to this team, e.g.<br/>    # "all_repo_read", "all_repo_triage", "all_repo_write", "all_repo_maintain",<br/>    # "all_repo_admin". The role is resolved to its ID by name at plan time, as<br/>    # IDs are not guaranteed stable across organizations.<br/>    #<br/>    # An organization role grants its permission on EVERY repository in the<br/>    # organization, present and future, without creating any per-repository<br/>    # object. It is the baseline layer; per-repository grants<br/>    # (github_team_repository, managed by tf-github-repos) are the exception<br/>    # layer on top.<br/>    #<br/>    # ⚠️ GitHub applies the HIGHER of the two. A per-repository grant BELOW this<br/>    # baseline is silently inert - it will appear in configuration and be ignored<br/>    # in practice. See the org_role_baseline check in checks.tf.<br/>    org_role = optional(string, null)<br/><br/>    # Team Members<br/>    members = list(object({<br/>      username = string<br/>      role     = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_org_role_baselines"></a> [org\_role\_baselines](#output\_org\_role\_baselines) | Organization-wide baseline access per team, keyed by team slug.<br/><br/>`base_role` is GitHub's own statement of the permission the role confers,<br/>expressed in ROLE vocabulary ("read", "triage", "write", "maintain", "admin").<br/>Repository permissions use different words for the same levels - "pull" for<br/>read and "push" for write - so a consumer comparing the two must translate.<br/><br/>Consumed by the caller to assert that no per-repository grant sits BELOW a<br/>team's baseline, which GitHub would silently ignore. |
| <a name="output_security_manager"></a> [security\_manager](#output\_security\_manager) | Details of the organization security\_manager role grant, or null when not configured |
| <a name="output_teams"></a> [teams](#output\_teams) | Map of team data to pass to other modules |
<!-- END_TF_DOCS -->
