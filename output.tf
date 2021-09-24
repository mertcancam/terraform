# latest ubuntu 20.04 image id
output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "security_group_public" {
  value = aws_security_group.public.id
}

output "instance_ip" {
  value = module.ec2_instance.public_ip
}
