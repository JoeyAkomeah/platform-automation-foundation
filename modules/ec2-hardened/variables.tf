variable "instance_type" {}
variable "ami_id" {}
variable "subnet_id" {}
variable "key_name" {}
variable "vpc_security_group_ids" { type = list(string) }
