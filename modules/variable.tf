
variable "vpc_cidr" {
  type    = string
  description = "Enter the VPC CIDR Value."
  // default = "172.31.0.0/16"
}

variable "vpc_name" {
  type    = string
  description = "Enter the VPC Tag Value"
}

variable "public_cidr" {
  type    = string
  default = "172.31.1.0/24"
}

variable "private_cidr" {
  type    = string
  default = "172.31.2.0/24"
}

variable "public_cidrs" {
  type = list(string)
  default = ["172.31.1.0/24","172.31.3.0/24"]
}

variable "private_cidrs" {
  type    = list(string)
  default = ["172.31.2.0/24","172.31.4.0/24"]
}

variable "access_ip" {
  type    = string
  default = "100.123.1.0/32"
}

variable "instance_type" {
  type    = string
 // default = "t2.micro"
}

variable "vol_size" {
  type    = number
  default = 8
}

variable "instance_key_name" {
  type    = string
  default = ""
}

variable "instance_count" {
  type    = number
  //default = 1
}

variable "bucket_name" {
  type        = string
  default = ""
  description = "provide name of the S3 bucket"
}


/*variable "bucket_acl" {
  type        = string
  description = "provide ACL for the S3 bucket i.e. private, public-read etc."
}*/

variable "cloud_env" {
  type    = string
  description = "Enter the Environment ( dev/qa/prod)."
  
}