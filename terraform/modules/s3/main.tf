# # S3 Bucket for frontend files
# resource "aws_s3_bucket" "website_bucket" {
#   bucket = "t-e-s-t-9-8-765432-1"
# }

# # Upload HTML files to S3

# resource "aws_s3_object" "index" {
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "index.html"
#   source = "../frontend/templates/index.html"
#   content_type = "text/html"
# }

# resource "aws_s3_object" "config" {
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "config.json"
#   source = "../frontend/config.json"
#   content_type = "application/json"
# }


# # resource "aws_cloudfront_distribution_invalidation" "invalidate" {
# #   distribution_id = aws_cloudfront_distribution.cdn.id
# #   paths           = ["/*"]
# # }


# resource "aws_s3_bucket_policy" "allow_cdn" {
#   bucket = aws_s3_bucket.website_bucket.id
#   policy = jsonencode({
#     Version = "2008-10-17",
#     Id = "PolicyForCloudFrontPrivateContent",
#     Statement = [
#       {
#         Sid       = "AllowCloudFrontServicePrincipal",
#         Effect    = "Allow",
#         Principal = {
#                 Service = "cloudfront.amazonaws.com"
#         },
#         Action     = "s3:GetObject",
#         Resource  = "${aws_s3_bucket.website_bucket.arn}/*",
#         Condition = {
#                     StringEquals = {
#                       "AWS:SourceArn" = "arn:aws:cloudfront::087143128777:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
#                 }
#             }

#         },
      
#     ]
#   })
#   depends_on = [
#     aws_cloudfront_distribution.s3_distribution
#   ]
# }


# locals {
#   s3_origin_id = "myS3Origin"
# }

# resource "aws_cloudfront_origin_access_control" "example" {
#   name                              = "example"
#   description                       = "Example Policy"
#   origin_access_control_origin_type = "s3"
#   signing_behavior                  = "always"
#   signing_protocol                  = "sigv4"
# }


# resource "aws_cloudfront_distribution" "s3_distribution" {
#   origin {
#     domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
#     origin_access_control_id = aws_cloudfront_origin_access_control.example.id
#     origin_id                = local.s3_origin_id
    
#   }

#   wait_for_deployment = true
#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Some comment"
#   default_root_object = "index.html"

#   default_cache_behavior {
#     allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "allow-all"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "whitelist"
#       locations        = ["US", "CA", "GB", "DE", "PL"]
#     }
#   }

#   tags = {
#     Environment = "production"
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
#   depends_on = [
#     aws_s3_bucket.website_bucket
#   ]
# }