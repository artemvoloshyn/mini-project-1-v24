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
# use_data_provision_script  = "<<-EOT
#   #!/bin/bash -xe
#   sudo apt-get update
#   sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common aws-cli
#   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#   sudo apt-get update
#   sudo apt-get install -y docker-ce docker-ce-cli containerd.io
#   sudo systemctl status docker
#   sudo usermod -aG docker ubuntu
# EOT"



