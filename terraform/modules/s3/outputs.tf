output "aws_s3_bucket_regional_domain_name" {
    value = aws_s3_bucket.website_bucket.bucket_domain_name
  
}

output "aws_s3_bucket_id" {
    value = aws_s3_bucket.website_bucket.id
  
}

output "aws_s3_bucket_arn" {
    value = aws_s3_bucket.website_bucket.arn
  
}