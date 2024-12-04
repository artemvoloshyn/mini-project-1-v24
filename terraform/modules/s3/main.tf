# S3 Bucket for frontend files
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.aws_s3_bucket_name
}

# Upload HTML files to S3

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_source
  content_type = "text/html"
}

resource "aws_s3_object" "config" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "config.json"
  source = var.config_json_source
  content_type = "application/json"
}