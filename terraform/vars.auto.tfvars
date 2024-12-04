aws_region                 = "us-east-1"
availability_zone          = "us-east-1a"
environment                = "cloudfront"
instance_type              = "t2.micro"
cidr                       = "10.0.0.0/16"
publicCIDR                 = "10.0.1.0/24"
security_group_name        = "cloudfront"
security_group_description = "cloudfront"
allowed_ports              = ["80", "22", "443", "8080", "8000", "8001"]
whitelist_locations        = ["US", "CA", "GB", "DE", "PL"]
aws_s3_bucket_name         = "t-e-s-t-9-8-765432-1"
index_html_source          = "../frontend/templates/index.html"
config_json_source         = "../frontend/config.json"
aws_user_account_id        = "087143128777"

