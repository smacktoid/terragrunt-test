# This is the root Terragrunt configuration file

# Generate a provider block automatically for all modules
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "local" {}
EOF
}

locals {
  # Absolute path to the repo root
  repo_root   = get_parent_terragrunt_dir()

  # Path to the modules directory
  modules_dir = "${local.repo_root}/modules"
}
