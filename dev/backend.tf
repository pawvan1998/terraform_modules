terraform {
  cloud {
    organization = "aws-cloud-tf"

    workspaces {
      name = "dev-aws-terraform-pawan-nw"
    }
  }
}