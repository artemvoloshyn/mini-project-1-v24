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
  subnet_id                   = var.aws_public_subnet_id
  vpc_security_group_ids      = var.aws_vpc_security_group_id
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
    # user_data = var.use_data_provision_script

  provisioner "remote-exec" {
    inline = [
      # Update package index
      "sudo apt-get update",

      # Install required packages
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common aws-cli",

      # Add Docker's official GPG key
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",

      # Set up the stable repository
      "echo 'deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",

      # Update apt package index again
      "sudo apt-get update",

      # Install Docker Engine
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",

      # Verify installation
      "sudo systemctl status docker",

      # Add current user to docker group
      "sudo usermod -aG docker ubuntu",

      # Optionally install Docker Compose (if needed)
      # "sudo curl -L 'https://github.com/docker/compose/releases/download/v1.29.2/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose",
      # "sudo chmod +x /usr/local/bin/docker-compose",
      # "docker compose version"
    ]
    # Connection block to specify SSH access
    connection {
      type        = "ssh"
      user        = "ubuntu"                           # Default username for Ubuntu AMIs
      private_key = file("~/.ssh/id_rsa")              # Path to your private key
      host        = self.public_ip                    # Use the instance's public IP for SSH
    }
  }

  tags = {
    Name = var.environment
  }
}
