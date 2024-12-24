locals {
  project = "12-public-modules"

  common_tags = {
    Project    = local.project
    Managed_By = "Terraform"
  }
}