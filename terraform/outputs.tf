output "EC2_public_IP" {
  value     = aws_instance.EC2.associate_public_ip_address
}
