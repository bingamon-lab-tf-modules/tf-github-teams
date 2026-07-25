locals {
  # Resolve the ID of the organization level "security_manager" role by name, as
  # the ID is not stable across organizations.
  security_manager_role_id = one([
    for role in data.github_organization_roles.this.roles : role.role_id
    if role.name == "security_manager"
  ])

  # Team slugs derived from the team names the same way GitHub derives them, so a
  # security manager team can be cross-referenced before the teams are created.
  github_team_slugs = [
    for team in var.github_teams : lower(replace(team.name, " ", "-"))
  ]
}
