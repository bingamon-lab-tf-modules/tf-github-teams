# Grant the organization security_manager role to a GitHub Team.
#
# This supersedes the deprecated github_organization_security_manager resource
# that was previously provided by the tf-github-secmgr module. Both resources
# call the same idempotent AssignOrgRoleToTeam API, so existing grants can be
# forgotten from the old module and re-created here without interruption.
resource "github_organization_role_team" "security_manager" {
  count = var.github_security_manager_team_slug == null ? 0 : 1

  role_id   = local.security_manager_role_id
  team_slug = var.github_security_manager_team_slug

  depends_on = [
    data.github_organization.this,
    github_team.this
  ]
}
