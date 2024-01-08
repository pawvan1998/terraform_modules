module "modules" {
  source = "../modules"
  cloud_env = "qa"
  vpc_name = "qa_vpc"
  instance_count = "2"
  instance_type = "t2.micro"
  vpc_cidr = "172.31.0.0/16"
  public_cidrs = ["172.31.3.0/24","172.31.4.0/24"]
  private_cidrs = ["172.31.5.0/24","172.31.6.0/24"]
  public_cidr = "172.31.1.0/24"
  private_cidr = "172.31.2.0/24"
  bucket_name = "qa-testing-terraform-s3-bucket-data"
  instance_key_name = "aws-hello-one"
}