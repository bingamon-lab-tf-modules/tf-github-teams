locals {
  # Resolve the ID of the organization level "security_manager" role by name, as
  # the ID is not stable across organizations.
  security_manager_role_id = one([
    for role in data.github_organization_roles.this.roles : role.role_id
    if role.name == "security_manager"
  ])

  # Every organization role in this organization, keyed by name. role_id is not
  # stable across organizations, so roles are always resolved by name. base_role
  # is GitHub's own statement of the permission the role confers ("read",
  # "triage", "write", "maintain", "admin") and is read live rather than
  # hard-coded, so the mapping stays correct if GitHub ever redefines a role.
  organization_roles_by_name = {
    for role in data.github_organization_roles.this.roles : role.name => role
  }

  # Teams that declare an organization-wide baseline, keyed by team slug.
  team_org_roles = {
    for team in var.github_teams :
    lower(replace(team.name, " ", "-")) => team.org_role
    if try(team.org_role, null) != null
  }

  # Team slugs derived from the team names the same way GitHub derives them, so a
  # security manager team can be cross-referenced before the teams are created.
  github_team_slugs = [
    for team in var.github_teams : lower(replace(team.name, " ", "-"))
  ]
}
