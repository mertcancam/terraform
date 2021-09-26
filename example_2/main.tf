provider "aws" {
  region = "us-west-1"
}

locals {
  subnet_id = element(tolist(data.aws_subnet_ids.subnets.ids), 0)
}

resource "aws_efs_file_system" "mert_efs" {
  creation_token = "mert_efs"

  tags = {
    Name = "Mert EFS"
  }
}

resource "aws_efs_mount_target" "mert_target_group" {
  file_system_id  = aws_efs_file_system.mert_efs.id
  subnet_id       = local.subnet_id
  security_groups = ["${aws_security_group.efs.id}"]
}

module "ec2_instance" {
  count                  = 2
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 3.0"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  key_name               = "mert"
  subnet_id       = local.subnet_id
  vpc_security_group_ids = ["${aws_security_group.efs.id}"]

  tags = {
    Name = "Mert EFS server ${count.index}"
  }
}