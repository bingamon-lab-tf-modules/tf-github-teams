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
