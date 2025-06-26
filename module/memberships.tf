# Add members to the GitHub Team
resource "github_team_membership" "this" {
  for_each = {
    for pair in flatten([
      for team in var.github_teams : [
        for member in team.members : {
          key       = "${team.name}:${member.username}"
          team_name = team.name
          username  = member.username
          role      = try(member.role, "member")
        }
      ]
    ]) : pair.key => pair
  }

  team_id  = github_team.this[each.value.team_name].id
  username = each.value.username
  role     = each.value.role
}
