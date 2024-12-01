output "aws_vpc_security_group_id" {
  value = aws_security_group.main_security_group.id

}

output "aws_public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

