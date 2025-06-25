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
