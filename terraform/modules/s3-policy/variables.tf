variable "aws_s3_bucket_id" {
    type = string
    description = "S3 bucket ID"
  
}

variable "aws_s3_bucket_arn" {
    type = string
    description = "S3 bucket ARN"
  
}

variable "aws_user_account_id" {
    type = string
    default = "AWS user account ID"
  
}

variable "aws_cloudfront_distribution_id" {
    type = string
    description = "Cloudfront ID to assign the policy"
  
}

