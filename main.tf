provider "aws" {
  region = var.region
}

data "aws_ami" "amz_linux" {
  most_recent = true

  # filter {
  #   name   = "name"
  #   values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]
  # }
  # owners = ["amazon"] # Canonical Ubuntu AWS account id
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical Ubuntu AWS account id
}

resource "aws_instance" "ansible_server" {
  ami           = data.aws_ami.amz_linux.id
  instance_type = "t3.small"

  lifecycle {
    create_before_destroy = true # Zero-downtime deployment
  }
}
