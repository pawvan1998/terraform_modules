terraform {
  cloud {
    organization = "aws-cloud-tf"

    workspaces {
      name = "qa-terraform-pawan"
    }
  }
}