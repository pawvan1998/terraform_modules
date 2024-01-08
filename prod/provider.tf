#terraform {
 # required_providers {
  #  aws = {
   #   source = "hashicorp/aws"
    #}
  #}
#}

provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "aws-hello.com"
    key    = "terraformstates/prod.tfstate"
    region = "ap-south-1"
  }
}
