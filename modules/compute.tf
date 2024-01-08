data "aws_ami" "ubuntu_ami" {
  most_recent = true

  owners = ["amazon"]  # Canonical's AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "terraform_full_ec2" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.ubuntu_ami.id
  key_name      = var.instance_key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "${var.cloud_env}_terraform_full_ec2_${count.index}"
  }
vpc_security_group_ids = [aws_security_group.terraform_full_sg.id]
  # Resource Referencing done from a different .tf
  subnet_id              = aws_subnet.terraform_public_full_subnet[0].id
  root_block_device {
    volume_size = var.vol_size
  }
}



/*data "aws_ami" "server_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "owner-alias"
      values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*-x86_64-gp2"]
  }
}

// Resource referencing from another file i.e networking.tf
resource "aws_instance" "terraform_fulll_ec2" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.server_ami.id
  key_name      = var.instance_key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "${var.cloud_env}terraform_fulll_ec2_${count.index}"
  }

   vpc_security_group_ids = [aws_security_group.terraform_full_sg.id]
  # Resource Referencing done from a different .tf
  subnet_id              = aws_subnet.terraform_public_full_subnet[0].id
  root_block_device {
    volume_size = var.vol_size
  }
}*/