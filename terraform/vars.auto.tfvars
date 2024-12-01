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
use_data_provision_script  = <<-EOL
   #!/bin/bash -xe
    # Update package index
    sudo apt-get update

    # Install required packages
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common awscli

    # Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Set up the stable repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Update apt package index again
    sudo apt-get update

    # Install Docker Engine
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io 

    # Verify installation
    sudo systemctl status docker

    # Add current user to docker group
    sudo usermod -aG docker ubuntu

    # # Install Docker Compose
    # sudo curl -L "https://github.com/docker/compose/releases/download/v1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # # Apply executable permissions to docker-compose
    # sudo chmod +x /usr/local/bin/docker-compose

    # Verify Docker Compose installation
    docker compose version



  EOL
