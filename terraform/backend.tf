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