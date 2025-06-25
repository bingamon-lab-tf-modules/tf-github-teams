terraform {
  required_version = ">= 1.9.0"
}

module "github_teams" {
  source = "github.com/bingamon-lab-tf-modules/tf-github-teams?ref=v1.0.0"
  #version = "~> 1.0"

  github_enterprise_slug   = "MyEnterprise"
  github_organization_name = "MyOrganization"

  github_teams = [
    {
      name        = "developers"
      description = "Development team"
      privacy     = "closed"
      members = [
        {
          username = "developer1"
          role     = "member"
        },
        {
          username = "team-lead"
          role     = "maintainer"
        }
      ]
    }
  ]
}
