# Assert that the organization exposes the security_manager role.
# Without it the role lookup returns null and the grant fails with an opaque error.
check "security_manager_role" {
  assert {
    condition = var.github_security_manager_team_slug == null || local.security_manager_role_id != null
    error_message = <<EOT
    ❌ Security manager role lookup has failed.

    The 'security_manager' role was not found in the '${var.github_organization_name}' organization.

    Available organization roles: ${join(", ", [
    for role in data.github_organization_roles.this.roles : "'${role.name}'"
])}

    Either enable the security manager role for the organization or unset
    'github_security_manager_team_slug'.
    EOT
}
}

# Assert that the security manager team is one of the teams managed by this module.
check "security_manager_team_slug" {
  assert {
    condition = var.github_security_manager_team_slug == null || contains(
      local.github_team_slugs,
      var.github_security_manager_team_slug
    )
    error_message = <<EOT
    ❌ Security manager team validation has failed.

    The team slug '${coalesce(var.github_security_manager_team_slug, "(unset)")}' is not managed by this module.

    Configured team slugs: ${join(", ", [for slug in local.github_team_slugs : "'${slug}'"])}

    Please add the team to 'github_teams' or correct 'github_security_manager_team_slug'.
    EOT
  }
}

# Assert that every org_role named by a team actually exists in the organization.
#
# A misspelled role would otherwise fail deep inside
# local.organization_roles_by_name with an opaque "key does not exist" error that
# names neither the team nor the role.
check "team_org_role_exists" {
  assert {
    condition = length(setsubtract(
      toset(values(local.team_org_roles)),
      toset(keys(local.organization_roles_by_name))
    )) == 0
    error_message = <<EOT
    ❌ Organization role lookup has failed.

    One or more teams declare an 'org_role' that does not exist in the
    '${var.github_organization_name}' organization: ${join(", ", [
    for slug, role in local.team_org_roles : "team '${slug}' -> '${role}'"
    if !contains(keys(local.organization_roles_by_name), role)
    ])}

    Available organization roles: ${join(", ", sort([
      for role in data.github_organization_roles.this.roles : "'${role.name}'"
]))}
    EOT
}
}
