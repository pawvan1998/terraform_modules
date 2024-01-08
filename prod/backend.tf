terraform {
  cloud {
    organization = "aws-cloud-tf"

    workspaces {
      name = "prod-terraform-pawan"
    }
  }
}