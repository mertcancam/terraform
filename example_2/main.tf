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

resource "aws_instance" "mert_app" {
  count           = 2
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  key_name        = "mert"
  security_groups = ["${aws_security_group.efs.id}"]
  subnet_id       = local.subnet_id

  tags = {
    Name = "Mert EFS server ${count.index}"
  }
}