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
