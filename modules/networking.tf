data "aws_availability_zones" "available" {}

resource "aws_vpc" "terraform_full_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.cloud_env}_var.vpc_name"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "full_internet_gateway" {
  vpc_id = aws_vpc.terraform_full_vpc.id

  tags = {
    Name = "${var.cloud_env}_terraform_full_internet_gateway"
  }
}

resource "aws_default_route_table" "terraform_private_rt" {
  default_route_table_id = aws_vpc.terraform_full_vpc.default_route_table_id

  tags = {
    Name = "${var.cloud_env}_terraform_private_rt"
  }
}

resource "aws_route_table" "terraform_public_rt" {
  vpc_id = aws_vpc.terraform_full_vpc.id

  tags = {
    Name = "${var.cloud_env}_terraform_public_rt"
  }
}

resource "aws_route" "terraform_full_route" {
  route_table_id         = aws_route_table.terraform_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.full_internet_gateway.id
}

resource "aws_security_group" "terraform_full_sg" {
  name        = "${var.cloud_env}_terraform_full_sg"
  description = "Security group for public instances"
  vpc_id      = aws_vpc.terraform_full_vpc.id
}

resource "aws_security_group_rule" "ingress_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = [var.access_ip]
  security_group_id = aws_security_group.terraform_full_sg.id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_full_sg.id
}

resource "aws_subnet" "terraform_public_full_subnet" {
  count                   = 1
  //count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.terraform_full_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.cloud_env}_terraform_public_full_subnet_${count.index}"
  }
}

resource "aws_subnet" "terraform_private_full_subnet" {
  count                     = 1
  //count                   = length(var.private_cidrs)
  vpc_id                    = aws_vpc.terraform_full_vpc.id
  cidr_block                = var.private_cidrs[count.index]
  map_public_ip_on_launch   = false
  availability_zone         = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.cloud_env}_terraform_private_full_subnet_${count.index}"
  }
}

resource "aws_route_table_association" "terraform_public_subnet_association" {
  count                   = 1
  subnet_id      = aws_subnet.terraform_public_full_subnet.*.id[count.index]
  route_table_id = aws_route_table.terraform_public_rt.id
}

resource "aws_route_table_association" "terraform_private_subnet_association" {
  count                   = 1
  subnet_id      = aws_subnet.terraform_private_full_subnet.*.id[count.index]
  route_table_id = aws_default_route_table.terraform_private_rt.id
}