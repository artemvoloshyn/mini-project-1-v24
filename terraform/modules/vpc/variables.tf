variable "cidr" {
  type        = string
  description = "for vpc"

}

variable "environment" {
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

variable "security_group_name" {
  type = string
  description = "Security group name"
}

variable "security_group_description" {
  type = string
  description = "Security group description"
}

variable "allowed_ports" {
  type        = list(any)
  description = "List of allowed ports"
  # default     = ["80", "22", "443", "8080", "8000", "8001"]

}

