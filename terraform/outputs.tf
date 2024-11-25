output "EC2 public IP" {
  value     = aws_instance.EC2.associate_public_ip_address
}
