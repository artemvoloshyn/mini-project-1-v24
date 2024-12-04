variable "aws_region" {
  type        = string
  description = "region"
}

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
  type        = string
  description = "Security group name"
}

variable "security_group_description" {
  type        = string
  description = "Security group description"
}

variable "allowed_ports" {
  type        = list(any)
  description = "List of allowed ports"
  # default     = ["80", "22", "443", "8080", "8000", "8001"]
}

variable "instance_type" {
  type        = string
  description = "value"
}

variable "aws_s3_bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "index_html_source" {
  type        = string
  description = "Path to index.html file to upload to S3"
}

variable "config_json_source" {
  type        = string
  description = "Path to config.json file to upload to S3  "
}

variable "aws_user_account_id" {
  type        = string
  description = "AWS user account ID number"
}

variable "whitelist_locations" {
  type        = list(any)
  description = "Locations from which access is allowed"
}