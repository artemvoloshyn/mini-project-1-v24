output "EC2_public_IP" {
  value = aws_instance.EC2.public_ip
  description = "Allocated public IP"
}