locals {
  Name    = "Jenkins-On-EC2"
  Project = "DevOps-Jenkins"
}

locals {
  common_tags = {
    Name           = local.Name
    DevOps_Project = local.Project
  }
}