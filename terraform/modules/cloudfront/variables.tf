variable "aws_s3_bucket_regional_domain_name" {
  type = string
  description = "S3 bucket name for serving files"
  
}

variable "environment" {
  type        = string
  description = "value"

}

variable "whitelist_locations" {
  type        = list(any)
  description = "List of allowed ports"
}