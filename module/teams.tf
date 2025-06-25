# Create a GitHub Team
resource "github_team" "this" {
  for_each = {
    for team in var.github_teams : team.name => team
  }

  name = each.value.name

  description = try(each.value.description, "")
  privacy     = try(each.value.privacy, "closed")
  ldap_dn     = try(each.value.ldap_dn, "")

}
