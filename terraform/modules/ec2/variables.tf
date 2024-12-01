variable "instance_type" {
  type        = string
  description = "value"

}

variable "environment" {
  type        = string
  description = "value"

}

variable "availability_zone" {
  type        = string
  description = "value"

}

variable "aws_vpc_security_group_id" {
  type = list(any)
  description = "AWS Security group ID for VPC"
}

variable "aws_public_subnet_id" {
  type = string
  description = "Public subnet id"
}

variable "use_data_provision_script" {
  type = string
  description = "Script/commands to provision EC2"
}