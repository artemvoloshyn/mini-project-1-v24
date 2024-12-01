# S3 Bucket policy for cloudfront to access

resource "aws_s3_bucket_policy" "allow_cdn" {
  bucket = var.aws_s3_bucket_id
  policy = jsonencode({
    Version = "2008-10-17",
    Id = "PolicyForCloudFrontPrivateContent",
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal",
        Effect    = "Allow",
        Principal = {
                Service = "cloudfront.amazonaws.com"
        },
        Action     = "s3:GetObject",
        Resource  = "${var.aws_s3_bucket_arn}/*",
        Condition = {
                    StringEquals = {
                      "AWS:SourceArn" = "arn:aws:cloudfront::${var.aws_user_account_id}:distribution/${var.aws_cloudfront_distribution_id}"
                }
            }

        },
      
    ]
  })
#   depends_on = [
#     aws_cloudfront_distribution.s3_distribution
#   ]
}


