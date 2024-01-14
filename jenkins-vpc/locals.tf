locals {
  Name    = "Vault-On-EC2"
  Project = "DevOps-Vault"
}

locals {
  common_tags = {
    Name           = local.Name
    DevOps_Project = local.Project
  }
}