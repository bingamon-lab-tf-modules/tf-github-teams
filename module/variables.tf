variable "github_organization_name" {
  type        = string
  description = "Required. The name of the GitHub organization to create the team in."
}

variable "github_security_manager_team_slug" {
  type        = string
  description = "Slug of the team to grant the organization security_manager role. Null disables the grant."
  default     = null
}

variable "github_teams" {
  type = list(object({
    # Team
    name                 = string
    description          = optional(string)
    privacy              = optional(string)
    ldap_dn              = optional(string)
    notification_setting = optional(string, "notifications_enabled")

    # Team Members
    members = list(object({
      username = string
      role     = optional(string)
    }))
  }))
  default = []

  validation {
    condition = alltrue([
      for team in var.github_teams : team.name != null && team.name != ""
    ])
    error_message = <<EOT
    ❌ Team validation has failed.

    All teams must have a non-empty 'name' field.

    Please check your team configuration and ensure every team has a valid name.
    EOT
  }

  validation {
    condition = alltrue([
      for team in var.github_teams :
      team.privacy == null || contains(["secret", "closed", "visible"], team.privacy)
    ])
    error_message = <<EOT
    ❌ Team privacy validation has failed.

    Team privacy must be one of 'secret', 'closed', or 'visible'.

    Please check your team configuration and ensure every team has a valid privacy setting.
    EOT
  }

  validation {
    condition = alltrue([
      for team in var.github_teams :
      contains(["notifications_enabled", "notifications_disabled"], team.notification_setting)
    ])
    error_message = <<EOT
    ❌ Team notification setting validation has failed.

    Team notification_setting must be either 'notifications_enabled' or 'notifications_disabled'.

    Please check your team configuration and ensure every team has a valid notification setting.
    EOT
  }

  validation {
    condition = alltrue([
      for team in var.github_teams : alltrue([
        for member in team.members : member.username != null && member.username != ""
      ])
    ])
    error_message = <<EOT
    ❌ Team member validation has failed.

    All team members must have a non-empty 'username' field.

    Please check your team member configurations.
    EOT
  }

  validation {
    condition = alltrue([
      for team in var.github_teams : alltrue([
        for member in team.members :
        member.role == null || contains(["member", "maintainer"], member.role)
      ])
    ])
    error_message = <<EOT
    ❌ Team member role validation has failed.

    Member roles must be either 'member' or 'maintainer'.

    Please check your team member role assignments.
    EOT
  }

  validation {
    condition     = length(var.github_teams) == length(distinct([for team in var.github_teams : team.name]))
    error_message = <<EOT
    ❌ Duplicate team names detected.

    Each team must have a unique name within the organization.

    Please check for duplicate team names in your configuration.
    EOT
  }
}