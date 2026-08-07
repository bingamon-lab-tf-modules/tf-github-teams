output "teams" {
  description = "Map of team data to pass to other modules"
  value = {
    for team_name, team in github_team.this : lower(replace(team_name, " ", "-")) => {
      id   = team.id
      slug = team.slug
      name = team.name
    }
  }
}

output "security_manager" {
  description = "Details of the organization security_manager role grant, or null when not configured"
  value = one([
    for grant in github_organization_role_team.security_manager : {
      role_id   = grant.role_id
      team_slug = grant.team_slug
    }
  ])
}

output "org_role_baselines" {
  description = <<-EOT
  Organization-wide baseline access per team, keyed by team slug.

  `base_role` is GitHub's own statement of the permission the role confers,
  expressed in ROLE vocabulary ("read", "triage", "write", "maintain", "admin").
  Repository permissions use different words for the same levels - "pull" for
  read and "push" for write - so a consumer comparing the two must translate.

  Consumed by the caller to assert that no per-repository grant sits BELOW a
  team's baseline, which GitHub would silently ignore.
  EOT
  value = {
    for slug, role_name in local.team_org_roles : slug => {
      role_name = role_name
      role_id   = local.organization_roles_by_name[role_name].role_id
      base_role = local.organization_roles_by_name[role_name].base_role
    }
  }
}
