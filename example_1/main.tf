provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  count                  = 3
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 3.0"
  name                   = var.instance_name
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.instance_key_name
  vpc_security_group_ids = ["${aws_security_group.public.id}"]

  tags = {
    Environment = "dev"
  }
}