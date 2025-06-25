module "test" {
  source = "../module"

  providers = {
    github = github.organization
  }

  github_enterprise_slug = "MyEnterprise"

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
    }
  ]
}