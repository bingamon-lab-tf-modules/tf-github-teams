# Organization-wide baseline access
#
# An organization role grants its permission on EVERY repository in the
# organization, present and future, and creates no per-repository object. This is
# the baseline layer of the access model; per-repository grants
# (github_team_repository, managed by tf-github-repos) are the exception layer.
#
# These assignments MUST be managed here rather than left to the GitHub UI. The
# provider offers no data source for organization-role -> team assignments
# (data.github_organization_roles returns role_id, name, base_role and
# permissions, but not who holds each role), so an unmanaged assignment is
# invisible to OpenTofu: it cannot be read, diffed or validated, and it silently
# raises effective permissions above whatever the configuration declares.
#
# That is not hypothetical. The `developers` team held all_repo_maintain while
# configuration declared `push`, so github_team_repository was written as push,
# read back as maintain, and re-planned on every run - twelve resources drifting
# in perpetuity with nothing in the repository explaining why.
resource "github_organization_role_team" "this" {
  for_each = local.team_org_roles

  role_id   = local.organization_roles_by_name[each.value].role_id
  team_slug = each.key

  depends_on = [
    data.github_organization.this,
    github_team.this
  ]
}
