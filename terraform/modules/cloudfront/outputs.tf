output "aws_cloudfront_distribution_id" {
    value = "${aws_cloudfront_distribution.s3_distribution.id}"
}

output "aws_cloudfront_domain_name" {
    value = aws_cloudfront_distribution.s3_distribution.domain_name
  
}