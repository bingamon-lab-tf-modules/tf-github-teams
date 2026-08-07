module "test" {
  source = "../module"

  providers = {
    github = github.organization
  }

  github_organization_name = "MyOrganization"

  github_teams = [
    {
      name        = "MyTeam"
      description = "My Team"
      privacy     = "secret"
      members = [
        {
          username = "MyUser"
          role     = "member"
        }
      ]
    },
    {
      name                 = "My Security Team"
      description          = "My Security Team"
      privacy              = "closed"
      notification_setting = "notifications_disabled"
      members = [
        {
          username = "MyUser"
          role     = "maintainer"
        }
      ]
    }
  ]

  github_security_manager_team_slug = "my-security-team"
}