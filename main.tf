provider "aws" {
  region = var.region
}

data "aws_ami" "amz_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]
  }
  owners = ["amazon"] # Canonical Ubuntu AWS account id
}

resource "aws_instance" "ansible_server" {
  ami           = data.aws_ami.amz_linux.id
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}
