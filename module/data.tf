# Lookup the GitHub Organization details.
# tflint-ignore: terraform_unused_declarations
data "github_organization" "this" {
  name = var.github_organization_name
}

# Lookup the organization roles so the security_manager role can be resolved by name.
data "github_organization_roles" "this" {}
