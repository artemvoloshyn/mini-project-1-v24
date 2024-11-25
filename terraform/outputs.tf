output "EC2_public_IP" {
  value     = aws_instance.EC2.associate_public_ip_address
}

output "CDN_URL" {
  value     = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "CDN_ID" {
  value     = aws_cloudfront_distribution.s3_distribution.id
}