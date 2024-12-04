# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Environment = "var.Environment"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.publicCIDR
  availability_zone = var.availability_zone
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "internet_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "internet_rta_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.internet_rt.id
}

resource "aws_security_group" "main_security_group" {
  name        = "main sg"
  description = "Main security group"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#### EC2 config #####

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_key_pair" "deploy-keys" {
  key_name   = "deploy"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_ebs_volume" "ebs_us-east-1f" {
  availability_zone = var.availability_zone
  size              = 10

  tags = {
    Name = "ebs"
  }
}


resource "aws_instance" "EC2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.main_security_group.id]
  key_name                    = aws_key_pair.deploy-keys.key_name
  associate_public_ip_address = true
  root_block_device {
    volume_size = 10
  }

  monitoring = true

  metadata_options {
    instance_metadata_tags      = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  user_data = <<-EOL
   #!/bin/bash -xe
    # Update package index
    sudo apt-get update
    
    # Install required packages
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common aws-cli
    
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

  tags = {
    Name = var.Environment
  }
}



# S3 Bucket for frontend files
resource "aws_s3_bucket" "website_bucket" {
  bucket = "t-e-s-t-9-8-765432-1"
}

# Upload HTML files to S3

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "../frontend/templates/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "config" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "config.json"
  source = "../frontend/config.json"
  content_type = "application/json"
}


# resource "aws_cloudfront_distribution_invalidation" "invalidate" {
#   distribution_id = aws_cloudfront_distribution.cdn.id
#   paths           = ["/*"]
# }


resource "aws_s3_bucket_policy" "allow_cdn" {
  bucket = aws_s3_bucket.website_bucket.id
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
        Resource  = "${aws_s3_bucket.website_bucket.arn}/*",
        Condition = {
                    StringEquals = {
                      "AWS:SourceArn" = "arn:aws:cloudfront::087143128777:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
                }
            }

        },
      
    ]
  })
  depends_on = [
    aws_cloudfront_distribution.s3_distribution
  ]
}


locals {
  s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_origin_access_control" "example" {
  name                              = "example"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.example.id
    origin_id                = local.s3_origin_id
    
  }

  wait_for_deployment = true
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "PL"]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  depends_on = [
    aws_s3_bucket.website_bucket
  ]
}