variable "aws_region" {
  type        = string
  description = "region"
}

variable "cidr" {
  type        = string
  description = "for vpc"

}

variable "Environment" {
  type        = string
  description = "value"
  default     = "presented"

}

variable "publicCIDR" {
  type        = string
  description = "value"

}

variable "availability_zone" {
  type        = string
  description = "value"

}

variable "allowed_ports" {
  type        = list(any)
  description = "List of allowed ports"
  default     = ["80", "22", "443", "8080"]

}

variable "instance_type" {
  type        = string
  description = "value"

}