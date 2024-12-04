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
    user_data =  fileexists("${path.root}/user_data.sh") ? file("${path.root}/user_data.sh") : null # var.use_data_provision_script

  tags = {
    Name = var.environment
  }
}
