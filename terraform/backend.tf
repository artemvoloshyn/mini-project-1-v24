resource "aws_s3_bucket" "tf_lock_testing_state_bucket" {
  bucket = "tf-lock-testing-state-bucket"
  lifecycle {
    # prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "tf_lock_testing_state_versioning" {
  bucket = aws_s3_bucket.tf_lock_testing_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_dynamodb_table" "tf_lock_testing_state_db_table" {
  name           = "tf-lock-testing-state-db-table"
  read_capacity  = 1
  write_capacity = 1
  #   billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# terraform {
#  backend "s3" {
#    bucket         = "tf-lock-testing-state-bucket"
#    key            = "tf-lock-testing-state-bucket.tfstate"
#    region         = "us-east-1"
#    dynamodb_table = "tf-lock-testing-state-db-table"
#    # encrypt        = true
#  }
#}



# # S3 Bucket for HTML files
# resource "aws_s3_bucket" "website_bucket" {
#   bucket = "t-e-s-t-9-8-7-6-54-3-2-1"
#   # acl    = "public-read"
#   # provider = aws

#   # website {
#   #   index_document = "index.html"
#   # }
# }

# # # Upload HTML files to S3
# # # resource "aws_s3_object" "index" {
# # #   for_each = fileset("../frontend/", "{template/index.html,config.json}") # Adjust the path and pattern as needed

# # #   bucket = aws_s3_bucket.website_bucket.id
# # #   key    = each.value                  # The name of the object in S3
# # #   source = "../frontend/${each.value}" # Path to the local file

# # #   # acl    = "public-read"
# # # }

# resource "aws_s3_object" "index" {
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "index.html"
#   source = "../frontend/templates/index.html"
# }

# resource "aws_s3_object" "config" {
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "config.json"
#   source = "../frontend/config.json"
# }