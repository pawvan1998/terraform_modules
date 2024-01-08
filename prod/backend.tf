#terraform {
#  organization = "aws-cloud-tf"

 #   workspaces {
  #    name = "prod-terraform-pawan"
   # }
  #}
#}



terraform {
  backend "s3" {
    bucket = "aws-hello.com"
    key    = "terraformstates/prod.tfstate"
    region = "ap-south-1"
  }
}
