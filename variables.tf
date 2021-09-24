variable "instance_name" {
  type        = string
  description = "Name of the ec2 instance"
  default     = "default-ec2"
}

variable "instance_type" {
  type        = string
  description = "Type of the ec2 instance"
  default     = "t3.micro"
}

variable "instance_key_name" {
  type        = string
  description = "Key pair name to be used for the ec2 instance"
}