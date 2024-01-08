#terraform {
 # cloud {
  #  organization = "aws-cloud-tf"

   # workspaces {
    #  name = "dev-aws-terraform-pawan-nw"
    #}
  #}

terraform {
  backend "s3" {
    bucket = "aws-hello.com"
    key    = "terraformstates/dev.tfstate"
    region = "ap-south-1"
  }
}
